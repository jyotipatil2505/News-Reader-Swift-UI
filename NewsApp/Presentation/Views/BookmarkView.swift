//
//  BookmarkedArticlesView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import SwiftUI

struct BookmarkView: View {
    @ObservedObject var viewModel: NewsViewModel
    
    init(viewModelFactory: ViewModelFactoryProtocol = ViewModelFactory()) {
        viewModel = viewModelFactory.createCryptoListViewModel()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isEmptyBookmarkedArticlesArray {
                    // Show default text if there are no bookmarked articles
                    Text("You haven’t bookmarked any articles yet. Browse and bookmark your favorites!")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                        .accessibilityIdentifier(AccessibilityIdentifier.noBookmarksFound)
                } else {
                    // Show the list of bookmarked articles
                    List(viewModel.bookmarkedArticles) { article in
                        NavigationLink(destination: NewsDetailView(article: article)) {
                            
                            VStack(alignment: .leading) {
                                Text(article.title)
                                    .font(.headline)
                                if let description = article.description {
                                    Text(description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .lineLimit(2)
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            .accessibilityIdentifier(AccessibilityIdentifier.bookmarkListView)
            .onAppear {
                viewModel.loadBookmarks() // Load bookmarks when view appears
            }
            .navigationTitle("Bookmarks")
        }
    }
}
