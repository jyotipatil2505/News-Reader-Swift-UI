//
//  NewsRepositoryProtocol.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

protocol NewsRepositoryProtocol {
    func fetchNewsFromLocal() async throws -> [ArticleModel]
    func saveNewsIntoLocal(_ articles: ArticleModel) async throws -> Bool
    func deleteNewsFromLocal(_ news: ArticleModel) async throws -> Bool
    func fetchTopHeadlinesFromNetwork(category: NewsCategory?) async throws -> [ArticleModel]
    func fetchEverythingFromNetwork(seartText: String) async throws -> [ArticleModel] 
}


