//
//  GetCryptoNewsUseCase.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

class FetchNewsUseCase {
    private let repository: NewsRepositoryProtocol

    init(repository: NewsRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchNewsFromNetwork(category: NewsCategory?) async throws -> [ArticleModel] {
        let localNews = try await repository.fetchNewsFromNetwork(category: category)
        return localNews
    }
    
    func saveNewsIntoLocal(articles: ArticleModel) async throws -> Bool {
        return try await repository.saveNewsIntoLocal(articles)
    }
    
    func deleteNewsFromLocal(articles: ArticleModel) async throws -> Bool {
        return try await repository.deleteNewsFromLocal(articles)
    }
    
    func fetchNewsFromLocal() async throws -> [ArticleModel] {
        let localNews = try await repository.fetchNewsFromLocal()
        return localNews
    }
}

