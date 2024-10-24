//
//  NewsListView.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import SwiftUI

struct NewsListView: View {
    @ObservedObject var viewModel = NewsViewModel()

    var body: some View {
        NavigationView {
            VStack {
                
                CategoryFilterView(viewModel: viewModel)  

                ZStack {
                    if viewModel.articles.isEmpty {
                        Text("No News Found")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity) 
                            .multilineTextAlignment(.center)
                            .padding()
                    } else {
                        List(viewModel.articles) { article in
                            NavigationLink(destination: NewsDetailView(article: article)) {
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
                                        viewModel.toggleBookmark(article: article)
                                    }) {
                                        Image(systemName: article.isBookmarked ? "bookmark.fill" : "bookmark")
                                            .foregroundColor(article.isBookmarked ? .yellow : .gray)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Top Headlines")
            .onAppear {
                viewModel.fetchNews()
            }
            .onChange(of: viewModel.selectedCategory) { _ in
                viewModel.fetchNews() // Refetch news when the category changes
            }
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct NewsRowView: View {
    let article: Article
    
    var body: some View {
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
        .padding(.vertical, 8)
    }
}


