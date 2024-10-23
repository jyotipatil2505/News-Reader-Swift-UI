//
//  NewsRepositoryProtocol.swift
//  NewsApp
//
//  Created by Jyoti Patil on 22/10/24.
//

import Foundation

protocol NewsRepositoryProtocol {
    func fetchNews(category: NewsCategory?, completion: @escaping (Result<[Article], NetworkError>) -> Void)
}
