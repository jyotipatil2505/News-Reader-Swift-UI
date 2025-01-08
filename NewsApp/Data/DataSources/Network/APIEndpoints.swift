//
//  Endpoints.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

enum APIEndpoints: String {
    case topHeadlines = "/v2/top-headlines"
    case everything = "v2/everything"
}

extension APIEndpoints {
    ///This endpoint provides live top and breaking headlines for a country,
    static func getTopHeadlines() -> Endpoint {
        return Endpoint(
            path: topHeadlines.rawValue,
            method: .GET)
    }
    ///This endpoint provides live top and breaking headlines for a country, specific category in a country.
    static func getTopHeadlinesBy(category: String) -> Endpoint {
        return Endpoint(
            path: topHeadlines.rawValue,
            method: .GET,
            queryParameters: ["category": category]
        )
    }
    ////endpoint :: Everything /v2/everything
    ////Search through millions of articles from over 150,000 large and small news sources and blogs.
    static func fetchEverything(searchText: String) -> Endpoint {
        return Endpoint(
            path: everything.rawValue,
            method: .GET,
            queryParameters: ["q": searchText]
        )
    }
}
