//
//  NewsReader+RealmMapper.swift
//  NewsReader
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

/// Extension to the ArticleModel class
extension ArticleModel {
    
    /// This method essentially prepares the data in the ArticleModel to be stored in the Realm database by converting it into a format (ArticleRealm) that Realm can handle.
    func toRealm() -> ArticleRealm {
        let realmModel = ArticleRealm()
        realmModel.id = self.id
        realmModel.title = self.title
        realmModel.articleDescription = self.description
        realmModel.url = self.url
        realmModel.urlToImage = self.urlToImage
        realmModel.isBookmarked = self.isBookmarked
        realmModel.publishedAt = self.publishedAt
        return realmModel
    }
}
