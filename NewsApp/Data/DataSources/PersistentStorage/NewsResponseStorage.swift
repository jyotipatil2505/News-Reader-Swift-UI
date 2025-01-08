//
//  NewsLocalDataSource.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

/// The NewsResponseStorage protocol defines the operations for interacting with the local storage for news articles.
protocol NewsResponseStorage {
    
    /// Fetches all news articles from the local storage.
    func fetchNews() async throws -> [ArticleModel]
    
    /// Saves a single ArticleModel to the local storage.
    func saveNews(_ news: ArticleModel) async throws -> Bool
    
    /// Deletes a specific ArticleModel from the local storage.
    func deleteNews(_ news: ArticleModel) async throws -> Bool
}
