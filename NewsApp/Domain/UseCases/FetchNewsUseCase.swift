//
//  FetchNewsUseCase.swift
//  NewsReader
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

/// The FetchNewsUseCaseProtocol defines the contract for a use case related to fetching news data, both from the network and local storage.
protocol FetchNewsUseCaseProtocol {
    func fetchTopHeadlinesFromNetwork(category: NewsCategory?) async throws -> [ArticleModel]
    func fetchEverythingFromNetwork(seartText: String) async throws -> [ArticleModel]
    func saveNewsIntoLocal(articles: ArticleModel) async throws -> Bool
    func deleteNewsFromLocal(articles: ArticleModel) async throws -> Bool
    func fetchNewsFromLocal() async throws -> [ArticleModel]
}

class FetchNewsUseCase: FetchNewsUseCaseProtocol {
    
    /// This property stores a reference to the repository that handles the actual fetching, saving, and deleting of data from both network and local storage.
    private let repository: NewsRepositoryProtocol

    init(repository: NewsRepositoryProtocol) {
        self.repository = repository
    }
    
    /// This method calls the repository’s fetchTopHeadlinesFromNetwork method to fetch the top headlines, optionally filtered by a category.
    func fetchTopHeadlinesFromNetwork(category: NewsCategory?) async throws -> [ArticleModel] {
        let remoteNews = try await repository.fetchTopHeadlinesFromNetwork(category: category)
        return remoteNews
    }
    
    /// This method calls the repository’s fetchEverythingFromNetwork to retrieve news based on the search text (seartText).
    func fetchEverythingFromNetwork(seartText: String) async throws -> [ArticleModel] {
        let remoteNews = try await repository.fetchEverythingFromNetwork(seartText: seartText)
        return remoteNews
    }
    
    /// This method saves a specific ArticleModel to local storage by calling the repository’s saveNewsIntoLocal method.
    func saveNewsIntoLocal(articles: ArticleModel) async throws -> Bool {
        return try await repository.saveNewsIntoLocal(articles)
    }
    
    /// This method deletes a specific ArticleModel from local storage by calling the repository’s deleteNewsFromLocal method.
    func deleteNewsFromLocal(articles: ArticleModel) async throws -> Bool {
        return try await repository.deleteNewsFromLocal(articles)
    }
    
    /// This method fetches news articles from local storage by calling the repository’s fetchNewsFromLocal method.
    func fetchNewsFromLocal() async throws -> [ArticleModel] {
        let localNews = try await repository.fetchNewsFromLocal()
        return localNews
    }
}

