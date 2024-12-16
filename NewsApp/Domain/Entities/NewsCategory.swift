//
//  NewsCategory.swift
//  NewsApp
//
//  Created by Jyoti Patil on 16/12/24.
//
import Foundation

enum NewsCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case business = "Business"
    case entertainment = "Entertainment"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
    var id: String { self.rawValue }
}
