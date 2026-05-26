import Foundation
import Amplify
import Combine

class ChatViewModel: ObservableObject {

    // MARK: Published Properties
    @Published var messages: [Message] = []
    @Published var newMessageText: String = ""
    @Published var errorMessage: String?

    private let messageService = MessageService()
    private var subscriptionTask: Task<Void, Never>?
    var currentUserEmail: String = ""

    // MARK: Public Methods

    func loadMessages() {
        Task {
            do {
                let currentUser = try await Amplify.Auth.getCurrentUser()
                let fetched = try await messageService.fetchMessages()
                await MainActor.run {
                    self.currentUserEmail = currentUser.username
                    self.messages = fetched.sorted { $0.timestamp < $1.timestamp }
                }
                startObservingMessages()
            } catch {
                await MainActor.run {
                    self.errorMessage = "Erro ao carregar mensagens: \(error.localizedDescription)"
                }
            }
        }
    }

    func sendMessage() {
        let body = newMessageText.trimmingCharacters(in: .whitespaces)
        guard !body.isEmpty else { return }

        newMessageText = ""

        Task {
            do {
                try await messageService.sendMessage(body: body, sender: currentUserEmail)
            } catch {
                await MainActor.run {
                    self.errorMessage = "Erro ao enviar mensagem: \(error.localizedDescription)"
                }
            }
        }
    }

    // MARK: Private Methods

    private func startObservingMessages() {
        subscriptionTask = Task {
            do {
                for try await message in messageService.observeMessages() {
                    await MainActor.run {
                        self.messages.append(message)
                    }
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Erro de conexão: \(error.localizedDescription)"
                }
            }
        }
    }

    deinit {
        subscriptionTask?.cancel()
    }
}
