//
//  NewsReader+RealmMapper.swift
//  NewsReader
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

extension ArticleModel {
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
