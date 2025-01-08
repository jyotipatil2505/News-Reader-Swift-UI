//
//  NewsReaderRealm.swift
//  NewsReader
//
//  Created by Jyoti Patil on 07/01/25.
//


import RealmSwift

class ArticleRealm: Object {
    @Persisted var id: String?
    @Persisted var title: String
    @Persisted var articleDescription: String?
    @Persisted var url: String
    @Persisted var urlToImage: String?
    @Persisted var isBookmarked: Bool
    @Persisted var publishedAt: String
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
