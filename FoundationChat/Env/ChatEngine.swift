//
//  ChatEngine.swift
//  FoundationChat
//
//  Created by Peter Salz on 21.09.25.
//

import FoundationModels
import SwiftUI

@Observable
class ChatEngine {

    private let model: SystemLanguageModel = .default
    private let session: LanguageModelSession
    private let conversation: Conversation

    var isAvailable: Bool {

        switch model.availability {
        case .available: true
        default: false
        }
    }

    var conversationHistory: String {
        #warning("Implement me")
    }

    var conversationHistorySize: Int {
        #warning("Implement me")
    }

    private var estimatedTokenCount: Int {
        #warning("Implement me")
    }

    private let maxTokens = 4096
    private let safeTokenLimit = 3500

    init(conversation: Conversation) {
        #warning("Implement me")
    }

    func prewarm() {
        session.prewarm()
    }

    func respondTo() async -> LanguageModelSession.ResponseStream<MessageGenerable>? {
        #warning("Implement me")
    }

    func summarize() async -> LanguageModelSession.ResponseStream<String>? {
        #warning("Implement me")
    }
}
