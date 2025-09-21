//
//  FoundationChatApp.swift
//  FoundationChat
//
//  Created by Peter Salz on 21.09.25.
//

import SwiftUI
import SwiftData

@main
struct FoundationChatApp: App {
    var body: some Scene {
        WindowGroup {
            ConversationsListView()
                .modelContainer(for: [Conversation.self, Message.self])
        }
    }
}
