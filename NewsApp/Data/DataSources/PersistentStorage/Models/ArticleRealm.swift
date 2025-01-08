//
//  NewsReaderRealm.swift
//  NewsReader
//
//  Created by Jyoti Patil on 07/01/25.
//


import RealmSwift
/// The ArticleRealm class defines a Realm model for storing news articles in the local storage using Realm.
class ArticleRealm: Object {
    /// A unique identifier for the article.
    @Persisted var id: String?
    /// The title of the news article.
    @Persisted var title: String
    /// A description of the article, which is optional.
    @Persisted var articleDescription: String?
    /// The URL of the article.
    @Persisted var url: String
    /// The URL to an image associated with the article, optional.
    @Persisted var urlToImage: String?
    ///  A flag indicating whether the article has been bookmarked by the user.
    @Persisted var isBookmarked: Bool
    /// The publication date of the article.
    @Persisted var publishedAt: String
    /// This method defines the primary key for the ArticleRealm object, which is id.
    override static func primaryKey() -> String? {
        return "id"
    }
}
