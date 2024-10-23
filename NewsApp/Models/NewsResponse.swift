//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import Foundation

struct NewsResponse: Codable {
    let status: String?
    let articles: [Article]
}
