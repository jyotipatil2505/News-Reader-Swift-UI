//
//  NewsCategory.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//
import Foundation

/// The NewsCategory enum defines various categories of news for the app.
enum NewsCategory: String, CaseIterable, Identifiable {
    
    /// Represents all news categories.
    case all = "All"
    
    /// Represents business-related news.
    case business = "Business"
    
    /// Represents entertainment-related news.
    case entertainment = "Entertainment"
    
    /// Represents health-related news.
    case health = "Health"
    
    /// Represents science-related news.
    case science = "Science"
    
    /// Represents sports-related news.
    case sports = "Sports"
    
    /// Represents technology-related news.
    case technology = "Technology"
    var id: String { self.rawValue }
}
