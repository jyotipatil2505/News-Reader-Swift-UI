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
        mockRepository.mockArticles = [mockArticle]
        
        // Create an expectation to wait for async operation
        let expectation = XCTestExpectation(description: "Fetch news successfully")
        
        // Act: Trigger the fetch news function
        viewModel.fetchNews()

        // Delay the check for async completion
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Assert: Check that articles are correctly loaded into the view model
            XCTAssertEqual(self.viewModel.articles.count, 1)
            XCTAssertEqual(self.viewModel.articles.first?.title, "Test Title")
            
            // Fulfill the expectation
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }


    // Test fetching news failure (simulating an error)
    func testFetchNewsFailure() {
        // Arrange: Set mock repository to return an error
        mockRepository.shouldReturnError = true
        
        // Create an expectation to wait for async operation
        let expectation = XCTestExpectation(description: "Fetch news failed")

        // Act: Trigger the fetch news function
        viewModel.fetchNews()

        // Wait asynchronously for the result
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Assert: Check if the error message and alert state are set correctly
            XCTAssertTrue(self.viewModel.showErrorAlert, "Error alert should be shown")
            XCTAssertEqual(self.viewModel.errorMessage, NetworkError.invalidURL.localizedDescription, "Error message should be correct")
            
            // Fulfill the expectation
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }

    // Test bookmarking an article
    func testToggleBookmark() {
        // Arrange: Set up mock article
        let mockArticle = Article(title: "Test Title", description: "Test Description", url: "https://example.com", urlToImage: nil, publishedAt: "2024-10-21T12:00:00Z")
        mockRepository.mockArticles = [mockArticle]
        
        // Create an expectation to wait for async operation
        let expectation = XCTestExpectation(description: "Fetch news successfully")

        // Act: Trigger the fetch news function
        viewModel.fetchNews()

        // Wait for fetchNews to populate articles
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Assert: Ensure articles are fetched
            XCTAssertNotNil(self.viewModel.articles.first, "Articles should not be nil after fetch")
            
            // Act: Toggle the bookmark status of the article
            let article = self.viewModel.articles.first!
            self.viewModel.toggleBookmark(article: article)

            // Assert: Check that the article is bookmarked and appears in the bookmarkedArticles array
            XCTAssertTrue(self.viewModel.articles.first!.isBookmarked)
            XCTAssertEqual(self.viewModel.bookmarkedArticles.count, 1)
            XCTAssertEqual(self.viewModel.bookmarkedArticles.first?.title, "Test Title")
            
            // Fulfill the expectation
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
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
