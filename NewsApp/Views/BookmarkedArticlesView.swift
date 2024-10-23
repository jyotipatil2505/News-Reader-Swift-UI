//
//  BookmarkedArticlesView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import SwiftUI

struct BookmarkedArticlesView: View {
    @ObservedObject var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.bookmarkedArticles.isEmpty {
                    // Show default text if there are no bookmarked articles
                    Text("You haven’t bookmarked any articles yet. Browse and bookmark your favorites!")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
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
            .onAppear {
                viewModel.loadBookmarks() // Load bookmarks when view appears
            }
            .navigationTitle("Bookmarks")
        }
    }
}


