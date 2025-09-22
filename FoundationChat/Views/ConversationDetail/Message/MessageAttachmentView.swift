//
//  MessageAttachmentView.swift
//  FoundationChat
//
//  Created by Peter Salz on 22.09.25.
//

import SwiftUI

struct MessageAttachmentView: View {

    let message: Message

    var body: some View {

        if attachmentIsVisible {

            VStack {

                if let attachmentThumbnail = message.attachmentThumbnail {

                    AsyncImage(url: URL(string: attachmentThumbnail)) { state in

                        if let image = state.image {

                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 100)
                                .clipped()

                        } else {
                            Color.secondary
                        }
                    }
                }

                if let attachmentTitle = message.attachmentTitle {

                    Text(attachmentTitle)
                        .foregroundStyle(.white)
                        .font(.title3)
                        .contentTransition(.interpolate)
                        .padding(.top)
                        .padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)
                }

                if let attachmentDescription = message.attachmentDescription {

                    Text(attachmentDescription)
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .contentTransition(.interpolate)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .background(.secondary)
            .cornerRadius(16)
        }
    }

    private var attachmentIsVisible: Bool {

        message.attachmentTitle != nil
            || message.attachmentThumbnail != nil
            || message.attachmentDescription != nil
    }
}
