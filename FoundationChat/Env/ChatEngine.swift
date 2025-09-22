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

        conversation.sortedMessage
            .map {
                "Role: \($0.role.rawValue)\nContent: \($0.content)"
            }
            .joined(separator: "\n\n")
    }

    var conversationHistorySize: Int {

        conversationHistory
            .components(separatedBy: .whitespacesAndNewlines)
            .count
    }

    private var estimatedTokenCount: Int {

        // Rough estimation: 1 token = 0.75 words for English
        Int(Double(conversationHistorySize) / 0.75)
    }

    private let maxTokens = 4096
    private let safeTokenLimit = 3500

    init(conversation: Conversation) {

        self.conversation = conversation

        self.session = LanguageModelSession(
            tools: [WebAnalyzerTool()],
            instructions: {
                """
                You're a helpful chatbot. The user will send you messages, and you'll respond to them.
                Be short, it's a chat application.
                You can also summarize the conversation when asked to.
                Each message will have a role, either user or assistant or system for initial conversation configuration.
                """
            }
        )
    }

    func prewarm() {
        session.prewarm()
    }

    func respondTo() async -> LanguageModelSession.ResponseStream<MessageGenerable>? {

        if estimatedTokenCount < safeTokenLimit {

            session.streamResponse(
                generating: MessageGenerable.self,
                prompt: {
                    """
                    Here is the conversation history:
                    \(conversationHistory)
                    Respond with the assistant role to the user's last message.
                    if there is a URL in the user's request, use the WebAnalyzerTool to analyze the webpage and add the attachment to the message.
                    Don't include any WebPageMetadata property in the response if there is no URL in the user's message.
                    """
                }
            )

        } else {

            session.streamResponse(
                generating: MessageGenerable.self,
                prompt: {
                    """
                    Here is the conversation summary:
                    \(conversation.summary ?? "No summary available")
                    And the last message from the user:
                    \(conversation.messages.last?.content ?? "No message available")
                    Respond with the assistant role to the user's last message.
                    if there is a URL in the user's request, use the WebAnalyzerTool to analyze the webpage and add the attachment to the message.
                    Don't include any WebPageMetadata property in the response if there is no URL in the user's message.
                    """
                }
            )
        }
    }

    func summarize() async -> LanguageModelSession.ResponseStream<String>? {

        if estimatedTokenCount < safeTokenLimit {

            session.streamResponse {
                """
                Write a 1-2 sentence summary of what was discussed.
                Start directly with the topic itself.
                Example: "Swift programming techniques and best practices for error handling."
                DO NOT start with phrases like "The conversation is about" or "The discussion covers".
                
                Conversation to summarize:
                \(conversationHistory)
                """
            }

        } else {

            session.streamResponse {

                """
                Update the summary to include new information, keeping it to 1-2 sentences.
                Start directly with the topic itself.
                DO NOT start with phrases like "The conversation is about" or "The discussion covers".
                
                Previous summary:
                \(conversation.summary ?? "No summary available")
                
                Latest message:
                \(conversation.messages.last?.content ?? "No message available")
                """
            }
        }
    }
}
