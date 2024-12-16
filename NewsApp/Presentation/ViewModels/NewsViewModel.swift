//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var articles: [ArticleModel] = []
    @Published var bookmarkedArticles: [ArticleModel] = []
    @Published var showErrorAlert: Bool = false
    @Published var showErrorMessage: String = ""
    @Published var selectedCategory: NewsCategory = .all
    @Published var loadingNewsInProgress: Bool = false

    // This is a computed property, but it's not @Published because it's derived from `articles`.
    var isEmptyArticlesArray: Bool {
        articles.isEmpty  // Returns true if articles is empty, false otherwise.
    }
    var isEmptyBookmarkedArticlesArray: Bool {
        bookmarkedArticles.isEmpty  // Returns true if articles is empty, false otherwise.
    }
    
    var isLoading: Bool {
        loadingNewsInProgress
    }
    
    private let newsUseCase: FetchNewsUseCase
    
    init(newsUseCase: FetchNewsUseCase) {
        self.newsUseCase = newsUseCase
        loadBookmarks()
        fetchNews()
    }
    
    func fetchNews() {
        loadingNewsInProgress = true
        Task {
            do {
                // Decide whether to fetch from network or local storage based on connectivity
                let articles = try await newsUseCase.fetchNewsFromNetwork(category: selectedCategory)
                                
                let validArticles = articles.filter { article in
                    // Exclude articles with title or description marked as "[Removed]"
                    return article.title != "[Removed]" && article.description != "[Removed]"
                }
                
                DispatchQueue.main.async {
                    // Update the isBookmarked flag based on bookmarkedArticles
                    self.articles = self.updateBookmarkedFlag(articlesArray: validArticles)
                }
            } catch {
                handleError(error: error)
            }
            
            DispatchQueue.main.async {
                // Hide the loader after the operation is complete (whether it succeeded or failed)
                self.loadingNewsInProgress = false
            }
        }
    }
    
    // Function to update isBookmarked flags based on bookmarkedArticles
    private func updateBookmarkedFlag(articlesArray: [ArticleModel]) -> [ArticleModel] {
        var updatedArticles = articlesArray
        for index in updatedArticles.indices {
            updatedArticles[index].isBookmarked = bookmarkedArticles.contains {
                $0.id == updatedArticles[index].id
            }
        }
        return updatedArticles
    }
    
    // Bookmarking functionality
    func toggleBookmark(article: ArticleModel) {
        // Find the index of the article in the articles array
        guard let index = articles.firstIndex(where: { $0.id == article.id }) else { return }
        // Toggle the isBookmarked flag in the articles array
        articles[index].isBookmarked.toggle()
        // Check if the article is being bookmarked
        if articles[index].isBookmarked {
            // Add the article to bookmarkedArticles only if it does not exist
            if !bookmarkedArticles.contains(where: { $0.id == articles[index].id }) {
                saveBookmark(article: articles[index])
            }
        } else {
            // Remove the article from bookmarkedArticles if it's unbookmarked
            removeBookmark(article: articles[index])
        }
        
    }
    
    // Save bookmarks to UserDefaults
    func saveBookmark(article: ArticleModel) {
        Task {
            do {
                let success = try await newsUseCase.saveNewsIntoLocal(articles: article)
                DispatchQueue.main.async {
                    if success {
                        self.bookmarkedArticles.append(article)
                    }
                }
            } catch {
                handleError(error: error)
            }
        }
    }
    
    func removeBookmark(article: ArticleModel) {
        Task {
            do {
                let success = try await newsUseCase.deleteNewsFromLocal(articles: article)
                DispatchQueue.main.async {
                    if success {
                        self.bookmarkedArticles.removeAll(where: { $0.id == article.id })
                    }
                }
                
            } catch {
                handleError(error: error)
            }
        }
    }
    
    // Load bookmarks from UserDefaults
    func loadBookmarks() {
        Task {
            do {
                let articles = try await newsUseCase.fetchNewsFromLocal()
                DispatchQueue.main.async {
                    self.bookmarkedArticles = articles
                }
            } catch {
                handleError(error: error)
            }
        }
    }
    
    private func handleError(error: Error) {
        DispatchQueue.main.async {
            self.showErrorAlert = true
            self.showErrorMessage = error.localizedDescription
        }
    }
}
