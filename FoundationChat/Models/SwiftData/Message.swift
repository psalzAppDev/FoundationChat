//
//  Message.swift
//  FoundationChat
//
//  Created by Peter Salz on 22.09.25.
//

import Foundation
import SwiftData

@Model
final class Message {

    var content: String
    var role: Role
    var timestamp: Date

    var attachmentTitle: String?
    var attachmentDescription: String?
    var attachmentThumbnail: String?
    var attachmentSummary: String?

    init(
        content: String,
        role: Role,
        timestamp: Date,
        attachmentTitle: String? = nil,
        attachmentDescription: String? = nil,
        attachmentThumbnail: String? = nil
    ) {

        self.content = content
        self.role = role
        self.timestamp = timestamp
        self.attachmentTitle = attachmentTitle
        self.attachmentDescription = attachmentDescription
        self.attachmentThumbnail = attachmentThumbnail
    }
}
