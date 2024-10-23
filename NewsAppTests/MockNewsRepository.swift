//
//  MockNewsService.swift
//  NewsAppTests
//
//  Created by Jyoti Patil on 22/10/24.
//

import Foundation
@testable import NewsApp // Import your app's module
class MockNewsRepository: NewsRepositoryProtocol {
    var shouldReturnError = false
    var mockArticles: [Article] = []
    
    func fetchNews(category: NewsCategory?, completion: @escaping (Result<[Article], NetworkError>) -> Void) {
        print("MockNewsRepository fetchNews called")
        if shouldReturnError {
            completion(.failure(.invalidURL)) // Simulate error
        } else {
            completion(.success(mockArticles)) // Simulate success
        }
    }
}

