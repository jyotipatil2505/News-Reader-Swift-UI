//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import Foundation

enum NewsCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case business = "Business"
    case entertainment = "Entertainment"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
    var id: String { self.rawValue }
}

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var bookmarkedArticles: [Article] = []
    @Published var showErrorAlert: Bool = false
    @Published var selectedCategory: NewsCategory = .all
    var errorMessage: String = ""
    
    private let newsService: NewsRepositoryProtocol
    
    init(newsService: NewsRepositoryProtocol = NewsRepository()) {
        self.newsService = newsService
        fetchNews()
        loadBookmarks()
    }
    
    func fetchNews() {
        newsService.fetchNews(category: selectedCategory) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    // Filter out articles that are marked as removed
                    let validArticles = articles.filter { article in
                        // Exclude articles with title or description marked as "[Removed]"
                        return article.title != "[Removed]" && article.description != "[Removed]"
                    }
                    self?.articles = validArticles
                    // Update the isBookmarked flag based on bookmarkedArticles
                    self?.updateBookmarkedFlags()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showErrorAlert = true
                }
            }
        }
    }
    
    // Function to update isBookmarked flags based on bookmarkedArticles
    private func updateBookmarkedFlags() {
        for index in articles.indices {
            if bookmarkedArticles.contains(where: { $0.id == articles[index].id }) {
                articles[index].isBookmarked = true
            } else {
                articles[index].isBookmarked = false
            }
        }
    }
    
    // Bookmarking functionality
    func toggleBookmark(article: Article) {
        // Find the index of the article in the articles array
        if let index = articles.firstIndex(where: { $0.id == article.id }) {
            // Toggle the isBookmarked flag in the articles array
            articles[index].isBookmarked.toggle()
            // Check if the article is being bookmarked
            if articles[index].isBookmarked {
                // Add the article to bookmarkedArticles only if it does not exist
                if !bookmarkedArticles.contains(where: { $0.id == articles[index].id }) {
                    bookmarkedArticles.append(articles[index])
                }
            } else {
                // Remove the article from bookmarkedArticles if it's unbookmarked
                bookmarkedArticles.removeAll { $0.id == articles[index].id }
            }
            // Save the updated bookmarks to UserDefaults
            saveBookmarks()
        }
    }
    
    // Save bookmarks to UserDefaults
    func saveBookmarks() {
        if let encoded = try? JSONEncoder().encode(bookmarkedArticles) {
            UserDefaults.standard.set(encoded, forKey: "bookmarkedArticles")
        }
    }
    
    // Load bookmarks from UserDefaults
    func loadBookmarks() {
        if let savedArticles = UserDefaults.standard.data(forKey: "bookmarkedArticles"),
           let decodedArticles = try? JSONDecoder().decode([Article].self, from: savedArticles) {
            bookmarkedArticles = decodedArticles
        }
    }
}
