//
//  File.swift
//  NewsReader
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

class NewsRepository: NewsRepositoryProtocol {
    
    private let localStorage: NewsResponseStorage
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol, localStorage: NewsResponseStorage) {
        self.localStorage = localStorage
        self.networkService = networkService
    }
    
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
    
    func fetchNewsFromLocal() async throws -> [ArticleModel] {
        let localNews = try await localStorage.fetchNews()
        return localNews
    }
    
    func saveNewsIntoLocal(_ news: ArticleModel) async throws -> Bool {
        return try await localStorage.saveNews(news)
    }
    
    func deleteNewsFromLocal(_ news: ArticleModel) async throws -> Bool {
        return try await localStorage.deleteNews(news)
    }
}
