//
//  MessageContentView.swift
//  FoundationChat
//
//  Created by Peter Salz on 22.09.25.
//

import SwiftUI

struct MessageContentView: View {

    let message: Message

    var body: some View {

        Text(message.content)
            .foregroundStyle(.white)
            .font(.subheadline)
            .contentTransition(.interpolate)
    }
}
