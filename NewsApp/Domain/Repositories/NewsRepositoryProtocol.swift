//
//  NewsRepositoryProtocol.swift
//  NewsApp
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

protocol NewsRepositoryProtocol {
    func fetchNewsFromLocal() async throws -> [ArticleModel]
    func saveNewsIntoLocal(_ articles: ArticleModel) async throws -> Bool
    func deleteNewsFromLocal(_ news: ArticleModel) async throws -> Bool
    func fetchNewsFromNetwork(category: NewsCategory?) async throws -> [ArticleModel]
}


