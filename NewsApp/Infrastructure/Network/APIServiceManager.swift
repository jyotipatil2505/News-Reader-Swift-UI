//
//  NewsRepository.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//
import Foundation

/* APIService Handled the logic for fetching crypto News list from the API */
class APIServiceManager: APIServiceProtocol {
    func fetchNews(category: String?) async throws -> [ArticleModel] {
        
        var queryItems = [URLQueryItem(name: "country", value: "us")]

        // Append category if provided
        if let category = category, !category.isEmpty, category != "All" {
            queryItems.append(URLQueryItem(name: "category", value: category))
        }
        let endpoint = Endpoint.createGETEndpoint(path: "/top-headlines", queryItems: queryItems)
        do {
            let newsResponse: NewsResponse = try await NetworkManager.shared.request(endpoint: endpoint)
            return newsResponse.articles
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}

