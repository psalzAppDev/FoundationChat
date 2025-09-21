//
//  ConversationsListView.swift
//  FoundationChat
//
//  Created by Peter Salz on 22.09.25.
//

import SwiftData
import SwiftUI

struct ConversationsListView: View {

    @Environment(\.modelContext)
    private var modelContext

    @Query
    private var conversations: [Conversation]

    @State
    private var path: [Conversation] = []

    var body: some View {
        #warning("Implement me")
    }
}
