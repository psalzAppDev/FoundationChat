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
        #warning("Implement me")
    }
}
