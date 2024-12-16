//
//  File.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

class NewsRepository: NewsRepositoryProtocol {
    
    private let networkDataSource: NewsNetworkDataSource
    private let localDataSource: NewsLocalDataSource

    init(networkDataSource: NewsNetworkDataSource, localDataSource: NewsLocalDataSource) {
        self.networkDataSource = networkDataSource
        self.localDataSource = localDataSource
    }
    
    func fetchNewsFromNetwork(category: NewsCategory?) async throws -> [ArticleModel] {
        // Fallback to network if local data is unavailable
        let networkNews = try await networkDataSource.fetchNews(category: category)
        return networkNews
    }
    
    func fetchNewsFromLocal() async throws -> [ArticleModel] {
        let localNews = try await localDataSource.fetchNews()
        return localNews
    }
    
    func saveNewsIntoLocal(_ news: ArticleModel) async throws -> Bool {
        return try await localDataSource.saveNews(news)
    }
    
    func deleteNewsFromLocal(_ news: ArticleModel) async throws -> Bool {
        return try await localDataSource.deleteNews(news)
    }
}
