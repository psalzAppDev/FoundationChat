//
//  WebPageMetadata.swift
//  FoundationChat
//
//  Created by Peter Salz on 22.09.25.
//

import FoundationModels

@Generable
struct WebPageMetadata: Encodable {

    @Guide(description: "The title of the webpage")
    let title: String

    @Guide(description: "The thumbnail of the webpage")
    let thumbnail: String?

    @Guide(description: "The description of the webpage")
    let description: String?
}
