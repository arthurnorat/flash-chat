import Foundation

struct Message: Identifiable {
    let id: String
    let sender: String
    let body: String
    let timestamp: Date
}
