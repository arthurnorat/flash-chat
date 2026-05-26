import Foundation
import Amplify

class MessageService {

    private let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    func sendMessage(body: String, sender: String) async throws {
        let document = """
        mutation CreateMessage($input: CreateMessageInput!) {
          createMessage(input: $input) {
            id sender body timestamp
          }
        }
        """

        let variables: [String: Any] = [
            "input": [
                "sender": sender,
                "body": body,
                "timestamp": dateFormatter.string(from: Date())
            ]
        ]

        let request = GraphQLRequest<JSONValue>(
            document: document,
            variables: variables,
            responseType: JSONValue.self
        )

        let result = try await Amplify.API.mutate(request: request)
        if case .failure(let error) = result {
            throw error
        }
    }

    func fetchMessages() async throws -> [Message] {
        let document = """
        query ListMessages {
          listMessages {
            items { id sender body timestamp }
          }
        }
        """

        let request = GraphQLRequest<JSONValue>(
            document: document,
            variables: nil,
            responseType: JSONValue.self
        )

        let result = try await Amplify.API.query(request: request)

        switch result {
        case .success(let json):
            return parseList(from: json)
        case .failure(let error):
            throw error
        }
    }

    func observeMessages() -> AsyncThrowingStream<Message, Error> {
        let document = """
        subscription OnCreateMessage {
          onCreateMessage { id sender body timestamp }
        }
        """

        let request = GraphQLRequest<JSONValue>(
            document: document,
            variables: nil,
            responseType: JSONValue.self
        )

        return AsyncThrowingStream { continuation in
            Task {
                let subscription = Amplify.API.subscribe(request: request)
                do {
                    for try await event in subscription {
                        if case .data(let result) = event,
                           case .success(let json) = result,
                           let message = self.parseSubscriptionMessage(from: json) {
                            continuation.yield(message)
                        }
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }

    // MARK: - Parsing

    private func parseSubscriptionMessage(from json: JSONValue) -> Message? {
        guard
            case .object(let root) = json,
            case .object(let data) = root["onCreateMessage"]
        else { return nil }
        return parseMessageFields(from: data)
    }

    private func parseList(from json: JSONValue) -> [Message] {
        guard
            case .object(let root) = json,
            case .object(let list) = root["listMessages"],
            case .array(let items) = list["items"]
        else { return [] }

        return items.compactMap { item in
            guard case .object(let data) = item else { return nil }
            return parseMessageFields(from: data)
        }
    }

    private func parseMessageFields(from data: [String: JSONValue]) -> Message? {
        guard
            case .string(let id) = data["id"],
            case .string(let sender) = data["sender"],
            case .string(let body) = data["body"],
            case .string(let timestampStr) = data["timestamp"]
        else { return nil }

        let timestamp = dateFormatter.date(from: timestampStr) ?? Date()
        return Message(id: id, sender: sender, body: body, timestamp: timestamp)
    }
}
