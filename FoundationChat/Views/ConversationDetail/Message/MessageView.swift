//
//  MessageView.swift
//  FoundationChat
//
//  Created by Peter Salz on 22.09.25.
//

import SwiftUI

struct MessageView: View {

    let message: Message

    var body: some View {
        #warning("Implement me")
    }
}

#Preview {

    LazyVStack {

        MessageView(
            message: .init(
                content: "Hell world this is a short message",
                role: .user,
                timestamp: .now
            )
        )

        MessageView(
            message: .init(
                content: "Hell world this is a short message",
                role: .assistant,
                timestamp: .now
            )
        )
    }
}
