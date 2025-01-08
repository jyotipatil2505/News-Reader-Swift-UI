//
//  NewsLocalDataSource.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

protocol NewsResponseStorage {
    func fetchNews() async throws -> [ArticleModel]
    func saveNews(_ news: ArticleModel) async throws -> Bool
    func deleteNews(_ news: ArticleModel) async throws -> Bool
}
