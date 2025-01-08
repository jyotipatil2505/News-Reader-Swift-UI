//
//  FetchNewsUseCase.swift
//  NewsReader
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

protocol FetchNewsUseCaseProtocol {
    func fetchTopHeadlinesFromNetwork(category: NewsCategory?) async throws -> [ArticleModel]
    func fetchEverythingFromNetwork(seartText: String) async throws -> [ArticleModel]
    func saveNewsIntoLocal(articles: ArticleModel) async throws -> Bool
    func deleteNewsFromLocal(articles: ArticleModel) async throws -> Bool
    func fetchNewsFromLocal() async throws -> [ArticleModel]
}

class FetchNewsUseCase: FetchNewsUseCaseProtocol {
    
    private let repository: NewsRepositoryProtocol

    init(repository: NewsRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchTopHeadlinesFromNetwork(category: NewsCategory?) async throws -> [ArticleModel] {
        let remoteNews = try await repository.fetchTopHeadlinesFromNetwork(category: category)
        return remoteNews
    }
    
    func fetchEverythingFromNetwork(seartText: String) async throws -> [ArticleModel] {
        let remoteNews = try await repository.fetchEverythingFromNetwork(seartText: seartText)
        return remoteNews
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

