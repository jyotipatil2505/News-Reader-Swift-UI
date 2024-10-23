//
//  NewsRepository.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import Foundation

/* NewsRepository Handled the logic for fetching news articles from the API */
class NewsRepository: NewsRepositoryProtocol {
    func fetchNews(category: NewsCategory? = .all, completion: @escaping (Result<[Article], NetworkError>) -> Void) {
        let endpoint = category == .all || category == nil ? Endpoint.topHeadlines() : Endpoint.topHeadlines(category: category?.rawValue)
        APIManager.shared.request(endpoint: endpoint) { (result: Result<NewsResponse, NetworkError>) in
            switch result {
            case .success(let newsResponse):
                completion(.success(newsResponse.articles))
            case .failure(let error):
                print("error :::::: ",error)
                completion(.failure(error))
            }
        }
    }
}
