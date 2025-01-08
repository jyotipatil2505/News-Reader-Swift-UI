//
//  NewsListView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import SwiftUI

/// This class serves as a wrapper for the NewsViewModelProtocol. It helps in managing and exposing the data related to news articles to the view.
final class NewsListViewModelWrapper: ObservableObject {
    /// This is an instance of NewsViewModelProtocol, which handles the logic for fetching and managing news data.
    var viewModel: NewsViewModelProtocol
    init(viewModel: NewsViewModelProtocol) {
        self.viewModel = viewModel
    }
}

/// The main view that displays a list of news articles. It also includes functionality for filtering articles by category, handling loading and error states, and allowing users to navigate to detailed news views.
struct NewsListView: View {
    @StateObject var viewModelWrapper: NewsListViewModelWrapper
    
    var body: some View {
        NavigationView {
            VStack {
                
                CategoryFilterView(viewModelWrapper: viewModelWrapper)

                ZStack {
                    if viewModelWrapper.viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if viewModelWrapper.viewModel.isEmptyArticlesArray {
                        Text("No News Found")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                            .padding()
                            .accessibilityIdentifier(AccessibilityIdentifier.noNewsFoundLabel)
                    } else {
                        List(viewModelWrapper.viewModel.articles) { article in
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
                viewModelWrapper.viewModel.fetchNews() // Refetch news when the category changes
            }
            .alert(isPresented: self.$viewModelWrapper.viewModel.showErrorAlert) {
                Alert(title: Text("Error"), message: Text(viewModelWrapper.viewModel.showErrorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct NewsRowView: View {
    let article: ArticleModel
    var viewModelWrapper: NewsListViewModelWrapper
    
    var body: some View {
        HStack {
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
            Spacer()
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


