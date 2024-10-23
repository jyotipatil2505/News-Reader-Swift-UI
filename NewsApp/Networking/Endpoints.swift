//
//  Endpoints.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import Foundation

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]?
    
    var baseUrl: String {
        var components = URLComponents(string: "https://newsapi.org")!
        components.path = "/V2" + path
        components.queryItems = queryItems
        return components.url?.absoluteString ?? ""
    }
    
    // Function to create a topHeadlines endpoint with an optional category
    static func topHeadlines(category: String? = nil) -> Endpoint {
        var queryItems = [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "apiKey", value: "fe194d91e52846b6b292081c34c917b0")
        ]
        
        // Add category to the query items if it's provided
        if let category = category, !category.isEmpty {
            queryItems.append(URLQueryItem(name: "category", value: category))
        }
        
        return Endpoint(path: "/top-headlines", method: .GET, queryItems: queryItems)
    }
}
