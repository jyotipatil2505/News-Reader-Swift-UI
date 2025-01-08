//
//  MainView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import SwiftUI

/// MainView is a SwiftUI view that represents the main user interface of the app, containing a TabView to switch between two primary sections: News and Bookmarks.
struct MainView: View {
    /// A view of type AnyView that represents the news section of the app.
    let newsView: AnyView
    
    /// A view of type AnyView that represents the bookmark section of the app.
    let bookmarkView: AnyView
    
    var body: some View {
        TabView {
            newsView
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
                .accessibilityIdentifier(AccessibilityIdentifier.newsTabButton)
            bookmarkView
                .tabItem {
                    Label("Bookmarks", systemImage: "bookmark.fill")
                }
                .accessibilityIdentifier(AccessibilityIdentifier.bookmarkTabButton)
            
        }
        .accessibilityIdentifier(AccessibilityIdentifier.tabBar)
    }
}
