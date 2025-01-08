//
//  NewsReaderRealm+DomainMapper.swift
//  NewsReader
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

/// Extension to the ArticleRealm class
extension ArticleRealm {
    
    /// This method converts the Realm object (ArticleRealm) back to a domain model (ArticleModel)
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
