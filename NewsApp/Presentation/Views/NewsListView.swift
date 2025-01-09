//
//  NewsListView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import SwiftUI

/// This class serves as a wrapper for the NewsViewModelProtocol. It helps in managing and exposing the data related to news articles to the view.
final class NewsListViewModelWrapper {
    
    /// This is an instance of NewsViewModelProtocol, which handles the logic for fetching and managing news data.
    var viewModel: NewsViewModelProtocol
    init(viewModel: NewsViewModelProtocol) {
        self.viewModel = viewModel
    }
}

/// The main view that displays a list of news articles. It also includes functionality for filtering articles by category, handling loading and error states, and allowing users to navigate to detailed news views.
struct NewsListView: View {
    @State var viewModelWrapper: NewsListViewModelWrapper
    
    var body: some View {
        
        NavigationView {
            VStack {
                CategoryFilterView(viewModelWrapper: viewModelWrapper)

                ZStack {
                    if viewModelWrapper.viewModel.isLoading {
                        
                        /// Displays a ProgressView when data is loading
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    } else if viewModelWrapper.viewModel.isEmptyArticlesArray {
                        
                        /// "No News Found" message when no articles are available
                        Text("No News Found")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                            .padding()
                            .accessibilityIdentifier(AccessibilityIdentifier.noNewsFoundLabel)
                    } else {
                        /// If there are news articles, they are displayed using a List.
                        List(viewModelWrapper.viewModel.articles) { article in
                            
                            /// Each article is wrapped in a NavigationLink, which presents the NewsDetailView upon row tap, allowing users to view the full details of the article.
                            NavigationLink(destination: NewsDetailView(article: article)) {
                                NewsRowView(article: article, viewModelWrapper: viewModelWrapper)
                            }
                        }
                    }
                }
            }
            .accessibilityIdentifier(AccessibilityIdentifier.newsListView)
            .navigationTitle("Top Headlines")
            .onAppear {
                viewModelWrapper.viewModel.fetchNews()
            }
            .onChange(of: viewModelWrapper.viewModel.selectedCategory) { oldValue, newValue in
                /// Refetch news when the category changes
                viewModelWrapper.viewModel.fetchNews()
            }
            .alert(isPresented: $viewModelWrapper.viewModel.showErrorAlert) {
                Alert(title: Text("Error"), message: Text(viewModelWrapper.viewModel.showErrorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

/// The NewsRowView is a SwiftUI view that displays an article in a row format
struct NewsRowView: View {
    
    let article: ArticleModel
    var viewModelWrapper: NewsListViewModelWrapper
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                
                /// Displays the article's title
                Text(article.title)
                    .font(.headline)
                
                /// Displays the article's description
                if let description = article.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
            }
            Spacer()
            /// A button to toggle the bookmark state of the article
            Button(action: {
                viewModelWrapper.viewModel.toggleBookmark(article: article)
            }) {
                Image(systemName: article.isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(article.isBookmarked ? .yellow : .gray)
            }
            .buttonStyle(PlainButtonStyle())
            .accessibilityIdentifier(AccessibilityIdentifier.bookmarkButton)
            .accessibilityLabel(article.isBookmarked ? "bookmark.fill" : "bookmark")
        }
        .padding(.vertical, 5)
    }
}


