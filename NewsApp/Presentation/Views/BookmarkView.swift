//
//  BookmarkedArticlesView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import SwiftUI

final class BookmarkViewModelWrapper: ObservableObject {
    var viewModel: NewsViewModelProtocol
    init(viewModel: NewsViewModelProtocol) {
        self.viewModel = viewModel
    }
}

struct BookmarkView: View {
    @StateObject var viewModelWrapper: BookmarkViewModelWrapper
    var body: some View {
        NavigationView {
            VStack {
                if viewModelWrapper.viewModel.isEmptyBookmarkedArticlesArray {
                    // Show default text if there are no bookmarked articles
                    Text("You haven’t bookmarked any articles yet. Browse and bookmark your favorites!")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                        .accessibilityIdentifier(AccessibilityIdentifier.noBookmarksFound)
                } else {
                    // Show the list of bookmarked articles
                    List(viewModelWrapper.viewModel.bookmarkedArticles) { article in
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
            .onAppear {
                viewModelWrapper.viewModel.loadBookmarks() // Load bookmarks when view appears
            }
            .navigationTitle("Bookmarks")
            .accessibilityIdentifier(AccessibilityIdentifier.bookmarkListView)
        }
    }
}
