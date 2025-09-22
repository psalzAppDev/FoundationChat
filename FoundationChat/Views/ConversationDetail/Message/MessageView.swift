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

        HStack {

            if message.role == .user {
                Spacer()
            }

            VStack(alignment: .leading) {

                MessageContentView(message: message)
                MessageAttachmentView(message: message)
            }
            .padding()
            .glassEffect(
                .regular.tint(message.role == .user ? .blue : .green),
                in: .rect(cornerRadius: 16)
            )
            .padding(.horizontal)
            .animation(.bouncy, value: message.content)

            if message.role == .assistant {
                Spacer()
            }
        }
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
