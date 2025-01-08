//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

/// The NewsResponse struct represents the structure of the response returned from the news API.
struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [ArticleModel]
}
