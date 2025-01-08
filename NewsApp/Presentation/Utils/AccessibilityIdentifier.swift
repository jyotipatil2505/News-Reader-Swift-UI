//
//  AccessibilityIdentifier.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//
import Foundation

/// A struct containing static constants used as accessibility identifiers for UI elements in the application.
/// These identifiers are essential for UI testing, ensuring reliable interaction with and verification of specific UI components.
/// Each identifier corresponds to a unique UI element to facilitate test automation and improve accessibility support.
struct AccessibilityIdentifier {
    static let noNewsFoundLabel = "AccessibilityIdentifierNoNewsFoundLabel"
    static let bookmarkButton = "AccessibilityIdentifierBookmarkButton"
    static let readMoreLink = "AccessibilityIdentifierReadMoreLink"
    static let bookmarkListView = "AccessibilityIdentifierBookmarkListView"
    static let newsListView = "AccessibilityIdentifierNewsListView"
    static let categoryFilterView = "AccessibilityIdentifierCategoryFilterView"
    static let newsTabButton = "AccessibilityIdentifierNewsTabButton"
    static let bookmarkTabButton = "AccessibilityIdentifierBookmarkTabButton"
    static let tabBar = "AccessibilityIdentifierTabBar"
    static let newsDetailsView = "AccessibilityIdentifierNewsDetailsView"
    static let noBookmarksFound = "AccessibilityIdentifierNoBookmarksFound"
}

