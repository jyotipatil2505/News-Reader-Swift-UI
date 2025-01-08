//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

struct ArticleModel: Codable, Identifiable {
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    var isBookmarked: Bool = false
    let publishedAt: String
    var id: String {
        title + publishedAt
    }

    // Codable keys to ensure proper encoding/decoding
    enum CodingKeys: String, CodingKey {
        case title, description, url, urlToImage, publishedAt
    }
}
