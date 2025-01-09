//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import Foundation
import Observation

protocol NewsViewModelProtocolInput {
    func fetchNews()
    func updateBookmarkedFlag(articlesArray: [ArticleModel]) -> [ArticleModel]
    func toggleBookmark(article: ArticleModel)
    func saveBookmark(article: ArticleModel)
    func removeBookmark(article: ArticleModel)
    func loadBookmarks()
}

protocol NewsViewModelProtocolOutput {
    var articles: [ArticleModel] { get }
    var bookmarkedArticles: [ArticleModel] { get }
    var showErrorAlert: Bool { get set }
    var showErrorMessage: String { get }
    var selectedCategory: NewsCategory { get set }
    var loadingNewsInProgress: Bool { get }
    var isEmptyArticlesArray: Bool { get }
    var isEmptyBookmarkedArticlesArray: Bool { get }
    var isLoading: Bool { get }
    
    func handleError(error: Error)
}

typealias NewsViewModelProtocol = NewsViewModelProtocolInput & NewsViewModelProtocolOutput

/// The NewsViewModel class is responsible for managing the data flow of news articles within the application.
/// It fetches news from an external source, manages bookmarked articles, and updates the UI state based on the results of these actions.
/// Additionally, it handles error messages and loading states, ensuring the user experience is smooth and responsive.
/// 
@Observable
class NewsViewModel: NewsViewModelProtocol {
    var articles: [ArticleModel] = []
    var bookmarkedArticles: [ArticleModel] = []
    var showErrorAlert: Bool = false
    var showErrorMessage: String = ""
    var selectedCategory: NewsCategory = .all
    var loadingNewsInProgress: Bool = false

    /// This is a computed property, but it's not @Published because it's derived from `articles`.
    var isEmptyArticlesArray: Bool {
        articles.isEmpty  // Returns true if articles is empty, false otherwise.
    }
    var isEmptyBookmarkedArticlesArray: Bool {
        bookmarkedArticles.isEmpty  // Returns true if articles is empty, false otherwise.
    }
    
    var isLoading: Bool {
        loadingNewsInProgress
    }
    
    private let newsUseCase: FetchNewsUseCaseProtocol
    
    /// Initializes the NewsViewModel with the newsUseCase that handles the actual fetching of news data.
    init(newsUseCase: FetchNewsUseCaseProtocol) {
        self.newsUseCase = newsUseCase
        loadBookmarks()
        fetchNews()
    }
    
    /// Fetches news articles either from the network, depending on connectivity. Filters out invalid articles and updates the articles array.
    func fetchNews() {
        loadingNewsInProgress = true
        Task {
            do {
                // Decide whether to fetch from network or local storage based on connectivity
                let category = selectedCategory == .all ? nil : selectedCategory
                let articles = try await newsUseCase.fetchTopHeadlinesFromNetwork(category: category)
                                
                let validArticles = articles.filter { article in
                    // Exclude articles with title or description marked as "[Removed]"
                    return article.title != "[Removed]" && article.description != "[Removed]"
                }
                
                DispatchQueue.main.async {
                    // Update the isBookmarked flag based on bookmarkedArticles
                    self.articles = self.updateBookmarkedFlag(articlesArray: validArticles)
                    Utilities.debugPrint(log: "self.articles :::: \(self.articles)")
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
    
    /// Iterates over the given articles and checks if each article is bookmarked, updating the isBookmarked flag accordingly.
    func updateBookmarkedFlag(articlesArray: [ArticleModel]) -> [ArticleModel] {
        var updatedArticles = articlesArray
        for index in updatedArticles.indices {
            updatedArticles[index].isBookmarked = bookmarkedArticles.contains {
                $0.id == updatedArticles[index].id
            }
        }
        return updatedArticles
    }
    
    /// Toggles the bookmark status of an article and updates the bookmarkedArticles array by adding or removing the article based on the new status.
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
    
    /// Saves a bookmarked article to local storage and updates the bookmarkedArticles array if the save is successful.
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
    
    /// Removes a bookmarked article from local storage and updates the bookmarkedArticles array accordingly.
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
    
    /// Loads the bookmarked articles from local storage into the bookmarkedArticles array.
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
    
    /// Handles errors by setting the showErrorAlert flag to true and updating the showErrorMessage with the error description.
    func handleError(error: Error) {
        DispatchQueue.main.async {
            self.showErrorAlert = true
            self.showErrorMessage = error.localizedDescription
        }
    }
}
