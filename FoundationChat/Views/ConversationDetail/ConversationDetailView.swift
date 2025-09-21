//
//  ConversationDetailView.swift
//  FoundationChat
//
//  Created by Peter Salz on 22.09.25.
//

import FoundationModels
import SwiftData
import SwiftUI

struct ConversationDetailView: View {

    @Environment(\.modelContext)
    private var modelContext

    @Environment(ChatEngine.self)
    private var chatEngine

    @State
    var newMessage: String = ""

    @State
    var conversation: Conversation

    @State
    var scrollPosition: ScrollPosition = .init()

    @State
    var isGenerating: Bool = false

    @FocusState
    var isInputFocused: Bool

    var body: some View {
        #warning("Implement me")
    }
}

extension ConversationDetailView {

    private func streamNewMessage() async {

        #warning("Implement me")
    }

    private func updateConversationSummary() async {

        #warning("Implement me")
    }
}

#Preview {

    @Previewable
    var conversation: Conversation = .init(
        messages: [
            .init(
                content: "Hello world",
                role: .user,
                timestamp: .now
            ),
            .init(
                content: "How may I assist you today?",
                role: .assistant,
                timestamp: .now
            )
        ],
        summary: "A preview conversation"
    )

    ConversationDetailView(conversation: conversation)
        .environment(ChatEngine(conversation: conversation))
}
