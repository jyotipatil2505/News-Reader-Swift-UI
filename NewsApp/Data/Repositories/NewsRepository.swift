//
//  File.swift
//  NewsReader
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

/// The NewsRepository class is responsible for fetching news data from both network and local storage sources.
/// It interacts with the NetworkServiceProtocol for network requests and NewsResponseStorage for local storage operations, handling errors from both sources.
class NewsRepository: NewsRepositoryProtocol {
    
    private let localStorage: NewsResponseStorage
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol, localStorage: NewsResponseStorage) {
        self.localStorage = localStorage
        self.networkService = networkService
    }
    
    /// Fetches top headlines from the network
    func fetchTopHeadlinesFromNetwork(category: NewsCategory? = nil) async throws -> [ArticleModel] {
        // Fallback to network if local data is unavailable
        do {
            let request = category == nil ? APIEndpoints.getTopHeadlines() : APIEndpoints.getTopHeadlinesBy(category: category?.rawValue ?? "")
            let response: NewsResponse = try await networkService.request(request: request, type: NewsResponse.self, decodingType: .useDefaultKeys)
            return response.articles
        } catch let error as NetworkError {
            throw error
        } catch {
            throw error
        }
    }
    
    /// Fetches news articles based on a search text.
    func fetchEverythingFromNetwork(seartText: String) async throws -> [ArticleModel] {
        do {
            let request = APIEndpoints.fetchEverything(searchText: seartText)
            let response: NewsResponse = try await networkService.request(request: request, type: NewsResponse.self, decodingType: .useDefaultKeys)
            return response.articles
        } catch let error as NetworkError {
            throw error
        } catch {
            throw error
        }
    }
    
    /// Retrieves news articles from local storage.
    func fetchNewsFromLocal() async throws -> [ArticleModel] {
        let localNews = try await localStorage.fetchNews()
        return localNews
    }
    
    /// Saves a news article into local storage.
    func saveNewsIntoLocal(_ news: ArticleModel) async throws -> Bool {
        return try await localStorage.saveNews(news)
    }
    
    /// Deletes a news article from local storage.
    func deleteNewsFromLocal(_ news: ArticleModel) async throws -> Bool {
        return try await localStorage.deleteNews(news)
    }
}
