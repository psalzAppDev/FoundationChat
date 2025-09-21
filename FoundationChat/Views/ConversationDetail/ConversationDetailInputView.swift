//
//  ConversationDetailInputView.swift
//  FoundationChat
//
//  Created by Peter Salz on 22.09.25.
//

import SwiftUI

struct ConversationDetailInputView: ToolbarContent {

    @Binding
    var newMessage: String

    @Binding
    var isGenerating: Bool

    var isInputFocused: FocusState<Bool>.Binding

    var onSend: () async throws -> Void

    var body: some ToolbarContent {
        #warning("Implement me")
    }
}

#Preview {

    @FocusState
    var isInputFocused: Bool

    NavigationStack {

        List {
            Text("Hello")
        }
        .toolbar {
            ConversationDetailInputView(
                newMessage: .constant(""),
                isGenerating: .constant(false),
                isInputFocused: $isInputFocused,
                onSend: {}
            )
        }
    }
}
