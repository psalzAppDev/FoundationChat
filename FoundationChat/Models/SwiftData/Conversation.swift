//
//  Conversation.swift
//  FoundationChat
//
//  Created by Peter Salz on 22.09.25.
//

import Foundation
import SwiftData

@Model
class Conversation {

    @Relationship(deleteRule: .cascade)
    var messages: [Message]

    var summary: String?

    var lastMessageTimestamp: Date {
        messages.last?.timestamp ?? .now
    }

    var sortedMessage: [Message] {
        messages.sorted(by: { $0.timestamp < $1.timestamp })
    }

    init(messages: [Message], summary: String?) {

        self.messages = messages
        self.summary = summary
    }
}
