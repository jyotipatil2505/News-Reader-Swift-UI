//
//  NewsLocalDataSource.swift
//  NewsApp
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

protocol NewsLocalDataSource {
    func fetchNews() async throws -> [ArticleModel]
    func saveNews(_ news: ArticleModel) async throws -> Bool
    func deleteNews(_ news: ArticleModel) async throws -> Bool
}
