//
//  WebAnalyzerTool.swift
//  FoundationChat
//
//  Created by Peter Salz on 22.09.25.
//

import Foundation
import FoundationModels
import SwiftSoup

struct WebAnalyzerTool: Tool {

    let name: String = "WebAnalyzer"
    let description: String = "Analyze a website and return the content in a structured way, like page title, description and summary."

    private let session: URLSession = .shared

    @Generable
    struct Arguments {

        @Guide(description: "The URL of the webpage to analyze")
        let url: String
    }

    func call(arguments: Arguments) async throws -> GeneratedContent {

        guard let url = URL(string: arguments.url) else {
            return GeneratedContent("Invalid URL provided: \(arguments.url)")
        }

        let (data, _) = try await session.data(from: url)
        let html = String(data: data, encoding: .utf8)!
        let soup = try SwiftSoup.parse(html)
        let title = try soup.title()
        let thumbnail = try soup.select("meta[property='og:image']").attr("content")
        let description = try soup.select("meta[name='description']").attr("content")

        return GeneratedContent(
            WebPageMetadata(
                title: title,
                thumbnail: thumbnail,
                description: description
            )
        )
    }
}
