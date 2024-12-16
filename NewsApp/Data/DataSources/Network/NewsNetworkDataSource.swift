//
//  CryptoNetworkDataSource.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

protocol NewsNetworkDataSource {
    func fetchNews(category: NewsCategory?) async throws -> [ArticleModel]
}
