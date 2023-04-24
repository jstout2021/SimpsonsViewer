//  Project: SimpsonsViewer 
// Created by Jason Stout on 4/24/23.
//
// Using Swift 5.0
// Running on macOS 13.2
// SimpsonsCharacter
//
// "Design is not just what it looks like and feels like. Design is how it works." - Steve Jobs

import Foundation

// MARK: - DuckDuckGoResponse
struct DuckDuckGoResponse: Codable {
    let relatedTopics: [RelatedTopic]
    
    enum CodingKeys: String, CodingKey {
        case relatedTopics = "RelatedTopics"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        relatedTopics = try container.decode([RelatedTopic].self, forKey: .relatedTopics)
    }
}

// MARK: - RelatedTopic
struct RelatedTopic: Codable {
    let firstURL: String
    let icon: Icon
    let result, text: String

    enum CodingKeys: String, CodingKey {
        case firstURL = "FirstURL"
        case icon = "Icon"
        case result = "Result"
        case text = "Text"
    }
    
    func parseName() -> String {
        let components = text.components(separatedBy: " - ")
        if let name = components.first {
            return name
        }
        return text
    }
}

// MARK: - Icon
struct Icon: Codable {
    let height, url, width: String

    enum CodingKeys: String, CodingKey {
        case height = "Height"
        case url = "URL"
        case width = "Width"
    }
}
