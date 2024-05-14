import Foundation

struct Quiz: Codable {
    let title: String
    let desc: String?
    let questions: [Question]
}

struct Question: Codable {
    let text: String
    let answer: String
    let answers: [String]
}
