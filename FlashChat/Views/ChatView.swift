import SwiftUI
import Amplify

struct ChatView: View {
    let onLogOut: () -> Void

    @StateObject private var viewModel = ChatViewModel()

    var body: some View {
        VStack(spacing: 0) {
            messagesList
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.horizontal)
            }
            messageInputBar
        }
        .navigationTitle(K.appName)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Log Out") {
                    Task {
                        await Amplify.Auth.signOut()
                        await MainActor.run { onLogOut() }
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadMessages()
        }
    }

    // MARK: - Messages List

    private var messagesList: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.messages) { message in
                            MessageBubble(
                                message: message,
                                isCurrentUser: message.sender == viewModel.currentUserEmail
                            )
                            .id(message.id)
                        }
                    }
                    .padding()
                    .frame(minHeight: geo.size.height, alignment: .bottom)
                }
                .onChange(of: viewModel.messages.count) { _, _ in
                    if let last = viewModel.messages.last {
                        withAnimation {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Input Bar

    private var messageInputBar: some View {
        HStack(spacing: 12) {
            TextField("Write a message...", text: $viewModel.newMessageText)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(20)

            Button(action: { viewModel.sendMessage() }) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(Color(K.BrandColors.purple))
                    .padding(10)
                    .background(Color.white)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(Color(K.BrandColors.purple))
    }
}

// MARK: - Message Bubble

struct MessageBubble: View {
    let message: Message
    let isCurrentUser: Bool

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if !isCurrentUser {
                Image(K.leftImageView)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            } else {
                Spacer(minLength: 60)
            }

            VStack(alignment: isCurrentUser ? .trailing : .leading, spacing: 2) {
                Text(message.body)
                Text(message.timestamp, format: .dateTime.hour().minute())
                    .font(.caption2)
                    .opacity(0.7)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                isCurrentUser
                    ? Color(K.BrandColors.lightPurple)
                    : Color(K.BrandColors.purple)
            )
            .foregroundColor(
                isCurrentUser
                    ? Color(K.BrandColors.purple)
                    : Color(K.BrandColors.lightPurple)
            )
            .cornerRadius(18)

            if isCurrentUser {
                Image(K.rightImageView)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            } else {
                Spacer(minLength: 60)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ChatView(onLogOut: {})
    }
}
