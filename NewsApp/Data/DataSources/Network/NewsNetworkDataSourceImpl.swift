//
//  CryptoNetworkDataSourceImpl.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

class NewsNetworkDataSourceImpl: NewsNetworkDataSource {
    private let apiService: APIServiceManager

    init(apiService: APIServiceManager) {
        self.apiService = apiService
    }

    func fetchNews(category: NewsCategory?) async throws -> [ArticleModel] {
        return try await apiService.fetchNews(category: category?.rawValue)
    }
}
