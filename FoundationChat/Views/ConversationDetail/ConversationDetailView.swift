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

        ScrollView {

            LazyVStack {
                ForEach(conversation.sortedMessage) { message in
                    MessageView(message: message)
                        .id(message.id)
                }
            }
            .scrollTargetLayout()
            .padding(.bottom, 50)
        }
        .onAppear {

            chatEngine.prewarm()

            isInputFocused = true

            withAnimation {
                scrollPosition.scrollTo(edge: .bottom)
            }
        }
        .scrollDismissesKeyboard(.interactively)
        .scrollPosition($scrollPosition, anchor: .bottom)
        .navigationTitle("Messages")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .toolbar {
            ConversationDetailInputView(
                newMessage: $newMessage,
                isGenerating: $isGenerating,
                isInputFocused: $isInputFocused,
                onSend: {
                    isGenerating = true
                    await streamNewMessage()
                    await updateConversationSummary()
                    isGenerating = false
                }
            )
        }
    }
}

extension ConversationDetailView {

    private func streamNewMessage() async {

        conversation.messages.append(
            Message(
                content: newMessage,
                role: .user,
                timestamp: .now
            )
        )

        try? modelContext.save()

        newMessage = ""

        withAnimation {
            scrollPosition.scrollTo(edge: .bottom)
        }

        if let stream = await chatEngine.respondTo() {

            let newMessage = Message(
                content: "...",
                role: .assistant,
                timestamp: .now
            )

            conversation.messages.append(newMessage)

            do {
                for try await part in stream {

                    newMessage.content = part.content.content ?? ""
                    newMessage.attachmentTitle = part.content.metdata?.title
                    newMessage.attachmentThumbnail = part.content.metdata?.thumbnail
                    newMessage.attachmentDescription = part.content.metdata?.description

                    scrollPosition.scrollTo(edge: .bottom)
                }

                try modelContext.save()

            } catch {
                newMessage.content = "Error: \(error.localizedDescription)"
            }
        }
    }

    private func updateConversationSummary() async {

        if let stream = await chatEngine.summarize() {

            do {
                for try await part in stream {
                    conversation.summary = part.content
                }

                try modelContext.save()

            } catch {
                conversation.summary = "Error: \(error.localizedDescription)"
            }
        }
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
