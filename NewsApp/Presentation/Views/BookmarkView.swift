//
//  BookmarkedArticlesView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import SwiftUI

/// This class serves as a wrapper for the NewsViewModelProtocol. It helps in managing and exposing the data related to news articles to the view.
final class BookmarkViewModelWrapper {
    
    /// This is an instance of NewsViewModelProtocol, which handles the logic for fetching and managing news data.
    var viewModel: NewsViewModelProtocol
    init(viewModel: NewsViewModelProtocol) {
        self.viewModel = viewModel
    }
}

/// The BookmarkView is a SwiftUI view that displays a list of bookmarked articles in a news app.
struct BookmarkView: View {
    
    /// This is an observable object wrapper for the NewsViewModelProtocol, which manages the logic for the bookmarked articles.
    /// This allows the view to react to changes in the view model and update the UI accordingly.
    @State var viewModelWrapper: BookmarkViewModelWrapper
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModelWrapper.viewModel.isEmptyBookmarkedArticlesArray {
                    
                    /// Show default text if there are no bookmarked articles
                    Text("You haven’t bookmarked any articles yet. Browse and bookmark your favorites!")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                        .accessibilityIdentifier(AccessibilityIdentifier.noBookmarksFound)
                } else {
                    
                    /// If there are bookmarked articles, they are displayed using a List.
                    List(viewModelWrapper.viewModel.bookmarkedArticles) { article in
                        
                        /// Each article is wrapped in a NavigationLink, which presents the NewsDetailView upon row tap, allowing users to view the full details of the article.
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
                /// Load bookmarks when view appears
                viewModelWrapper.viewModel.loadBookmarks()
            }
            .navigationTitle("Bookmarks")
            .accessibilityIdentifier(AccessibilityIdentifier.bookmarkListView)
        }
    }
}
