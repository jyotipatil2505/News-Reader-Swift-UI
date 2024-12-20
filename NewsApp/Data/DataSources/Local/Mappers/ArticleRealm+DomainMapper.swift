//
//  CryptoCoinRealm+DomainMapper.swift
//  CryptoCoin
//
//  Created by Jyoti Patil on 05/12/24.
//

import Foundation

// Map Realm Object to Domain Model
extension ArticleRealm {
    func toDomain() -> ArticleModel {
        return ArticleModel(
            title: self.title,
            description: self.articleDescription,
            url: self.url,
            urlToImage: self.urlToImage,
            isBookmarked: self.isBookmarked,
            publishedAt: self.publishedAt
        )
    }
}
