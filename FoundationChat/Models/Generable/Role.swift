//
//  Role.swift
//  FoundationChat
//
//  Created by Peter Salz on 22.09.25.
//

import FoundationModels
import SwiftData

@Generable
enum Role: String, Codable, Hashable, CaseIterable {

    case user = "User"
    case assistant = "Assistant"
    case system = "System"
}
