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
        #warning("Implement me")
    }

    var sortedMessage: [Message] {
        #warning("Implement me")
    }

    init(messages: [Message], summary: String?) {

        self.messages = messages
        self.summary = summary
    }
}
