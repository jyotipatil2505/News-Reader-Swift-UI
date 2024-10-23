//
//  NewsViewModelTests.swift
//  NewsAppTests
//
//  Created by Jyoti Patil on 22/10/24.
//
import XCTest
@testable import NewsApp // Import your app's module

class NewsViewModelTests: XCTestCase {

    var viewModel: NewsViewModel!
    var mockRepository: MockNewsRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockNewsRepository()
        viewModel = NewsViewModel(newsService: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }

    // Test successful fetching of news articles
    func testFetchNewsSuccess() {
        // Arrange: Set up mock articles
        let mockArticle = Article(title: "Test Title", description: "Test Description", url: "https://example.com", urlToImage: nil, publishedAt: "2024-10-21T12:00:00Z")
        print("mockArticle ::::::: ",mockArticle)
        mockRepository.mockArticles = [mockArticle]

        // Act: Trigger the fetch news function
        viewModel.fetchNews()

        // Assert: Check that articles are correctly loaded into the view model
        XCTAssertEqual(viewModel.articles.count, 1)
        XCTAssertEqual(viewModel.articles.first?.title, "Test Title")
    }

    // Test fetching news failure (simulating an error)
    func testFetchNewsFailure() {
        // Arrange: Set mock repository to return an error
        mockRepository.shouldReturnError = true

        // Act: Trigger the fetch news function
        viewModel.fetchNews()
        
        print("viewModel.errorMessage :::::: ",viewModel.errorMessage)

        // Assert: Check if the error message and alert state are set correctly
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.errorMessage, NetworkError.invalidURL.localizedDescription)
    }

    // Test bookmarking an article
    func testToggleBookmark() {
        // Arrange: Set up mock article
        let mockArticle = Article(title: "Test Title", description: "Test Description", url: "https://example.com", urlToImage: nil, publishedAt: "2024-10-21T12:00:00Z")
        mockRepository.mockArticles = [mockArticle]
        viewModel.fetchNews()

        // Act: Toggle the bookmark status of the article
        let article = viewModel.articles.first!
        viewModel.toggleBookmark(article: article)

        // Assert: Check that the article is bookmarked and appears in the bookmarkedArticles array
        XCTAssertTrue(viewModel.articles.first!.isBookmarked)
        XCTAssertEqual(viewModel.bookmarkedArticles.count, 1)
        XCTAssertEqual(viewModel.bookmarkedArticles.first?.title, "Test Title")
    }

    // Test removing a bookmark from an article
    func testRemoveBookmark() {
        // Arrange: Add a mock article and bookmark it
        let mockArticle = Article(title: "Test Title", description: "Test Description", url: "https://example.com", urlToImage: nil, isBookmarked: true, publishedAt: "2024-10-21T12:00:00Z")
        viewModel.bookmarkedArticles = [mockArticle]
        viewModel.articles = [mockArticle]

        // Act: Toggle the bookmark (remove it)
        viewModel.toggleBookmark(article: mockArticle)

        // Assert: Check that the article is unbookmarked and removed from the bookmarkedArticles array
        XCTAssertFalse(viewModel.articles.first!.isBookmarked)
        XCTAssertTrue(viewModel.bookmarkedArticles.isEmpty)
    }

    // Test loading bookmarked articles from UserDefaults
    func testLoadBookmarks() {
        // Arrange: Create a mock bookmarked article and save it to UserDefaults
        let mockArticle = Article(title: "Bookmarked Article", description: "Test Description", url: "https://example.com", urlToImage: nil, isBookmarked: true, publishedAt: "2024-10-21T12:00:00Z")
        viewModel.bookmarkedArticles = [mockArticle]
        viewModel.saveBookmarks()

        // Act: Clear the bookmarks in the viewModel, then load from UserDefaults
        viewModel.bookmarkedArticles = []
        viewModel.loadBookmarks()

        // Assert: Check that the bookmarked articles are correctly loaded from UserDefaults
        XCTAssertEqual(viewModel.bookmarkedArticles.count, 1)
        XCTAssertEqual(viewModel.bookmarkedArticles.first?.title, "Bookmarked Article")
    }
}
