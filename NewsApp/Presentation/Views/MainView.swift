//
//  MainView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            NewsListView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
                .accessibilityIdentifier(AccessibilityIdentifier.newsTabButton)
            BookmarkView()
                .tabItem {
                    Label("Bookmarks", systemImage: "bookmark.fill")
                }
                .accessibilityIdentifier(AccessibilityIdentifier.bookmarkTabButton)

        }
        .accessibilityIdentifier(AccessibilityIdentifier.tabBar)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
