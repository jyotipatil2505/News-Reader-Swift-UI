//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [ArticleModel]
}
