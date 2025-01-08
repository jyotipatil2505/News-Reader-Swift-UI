//
//  NewsRepositoryProtocol.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

/// The NewsRepositoryProtocol defines the methods that any class or service implementing this protocol must provide for fetching, saving, and deleting news data, both locally and from a network.
protocol NewsRepositoryProtocol {
    
    /// This method fetches news articles from local storage.
    func fetchNewsFromLocal() async throws -> [ArticleModel]
    
    /// This method saves a single ArticleModel into local storage.
    func saveNewsIntoLocal(_ articles: ArticleModel) async throws -> Bool
    
    /// This method deletes a specific ArticleModel from local storage.
    func deleteNewsFromLocal(_ news: ArticleModel) async throws -> Bool
    
    /// This method fetches the top headlines from the network, with an optional filter by NewsCategory.
    func fetchTopHeadlinesFromNetwork(category: NewsCategory?) async throws -> [ArticleModel]
    
    /// This method fetches all news articles from the network based on a search text.
    func fetchEverythingFromNetwork(seartText: String) async throws -> [ArticleModel]
}


