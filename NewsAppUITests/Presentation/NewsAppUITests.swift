//
//  NewsAppUITests.swift
//  NewsAppUITests
//
//  Created by Jyoti Patil on 07/01/25.
//

import XCTest
@testable import NewsApp

final class NewsAppUITests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testNewsTabUI() {
        // Launch the app
        let app = XCUIApplication()
        app.launch()
        
        print(app.debugDescription)
        sleep(5)  // Add a small delay to let the UI load
        
        // Verify that the tabBar exists
        let tabBar = app.otherElements[AccessibilityIdentifier.tabBar]
        XCTAssertTrue(tabBar.waitForExistence(timeout: 10), "Tab bar should exist")
        
        // Verify the "News" tab button exists
        let newsTabButton = app.otherElements[AccessibilityIdentifier.newsTabButton]
        //OR :::: :let newsTabButton = tabBar.buttons.element(boundBy: 0)  // First tab (News)
        XCTAssertTrue(newsTabButton.waitForExistence(timeout: 10), "News tab button should exist")
        
        // Verify the content for the "News" tab
        let newsListView = app.scrollViews[AccessibilityIdentifier.newsListView] // Assuming you have this identifier set
        XCTAssertTrue(newsListView.waitForExistence(timeout: 15), "News List View should appear after tapping the News tab")
    }
    
    func testBookmarButtonUI() {
        let app = XCUIApplication()
        app.launch()
        
        print(app.debugDescription)
        sleep(5)  // Add a small delay to let the UI load
        
        // Verify the content for the "News" tab
        let newsListView = app.scrollViews[AccessibilityIdentifier.newsListView] // Assuming you have this identifier set
        XCTAssertTrue(newsListView.waitForExistence(timeout: 15), "News List View should exist")
        
        // Get the list of article cells
        let articleCells = app.cells
        let cellCount = articleCells.count
        
        if cellCount > 0 {
            
            // Verify the presence of a list of articles
            let firstArticleCell = app.cells.element(boundBy: 0)
            XCTAssertTrue(firstArticleCell.waitForExistence(timeout: 10), "First article cell should exist in the list")
            
            // Test the bookmark button
            let bookmarkButton = firstArticleCell.buttons.matching(identifier: AccessibilityIdentifier.bookmarkButton).element(boundBy: 1)
            XCTAssertTrue(bookmarkButton.exists, "Bookmark button should exist for the first article")
            
            // Check initial bookmark state (e.g., bookmark state)
            XCTAssertEqual(bookmarkButton.label, "bookmark", "Bookmark button should initially be in the unbookmarked state")
            
            // Tap the bookmark button
            bookmarkButton.tap()
            
            // Verify the bookmark button updates to the bookmark.fill state
            XCTAssertEqual(bookmarkButton.label, "bookmark.fill", "Bookmark button should update to the bookmarked state after tapping")
            
            // Tap the bookmark button again to unbookmark
            bookmarkButton.tap()
            
            // Verify the bookmark button returns to the bookmark state
            XCTAssertEqual(bookmarkButton.label, "bookmark", "Bookmark button should return to the unbookmarked state after tapping again")
            
        } else {
            XCTFail("No articles found to test the bookmark functionality")
        }
    }
    
    func testCategoryFilterViewUI() {
        // Launch the app
        let app = XCUIApplication()
        app.launch()
        
        // Test category selection (if implemented)
        let categoryFilterView = app.staticTexts[AccessibilityIdentifier.categoryFilterView]
        XCTAssertTrue(categoryFilterView.waitForExistence(timeout: 10), "Category Filter View should exist")
        
        // Verify the presence of all categories
        for category in NewsCategory.allCases {
            let categoryButton = app.staticTexts[category.rawValue]
            XCTAssertTrue(categoryButton.waitForExistence(timeout: 10), "\(category.rawValue) category button should exist")
        }
    }
    
    func testNewsDetailsViewUI() {
        
        let app = XCUIApplication()
        app.launch()
        sleep(5)  // Add a small delay to let the UI load
        
        // Debug: Print all elements
        print(app.debugDescription)
        
        // Verify the content for the "News" tab
        let newsListView = app.scrollViews[AccessibilityIdentifier.newsListView] // Assuming you have this identifier set
        XCTAssertTrue(newsListView.waitForExistence(timeout: 15), "News List View should exist")
        
        // Get the list of article cells
        let articleCells = app.cells
        let cellCount = articleCells.count
        
        if cellCount > 0 {
            // Verify the presence of a list of articles
            let firstArticleCell = app.cells.element(boundBy: 0)
            XCTAssertTrue(firstArticleCell.waitForExistence(timeout: 10), "First article cell should exist in the list")
            
            // Interact with the first article
            firstArticleCell.tap()
            let newsDetailsView = app.scrollViews[AccessibilityIdentifier.newsDetailsView] // Replace with the actual title or accessibility identifier
            XCTAssertTrue(newsDetailsView.waitForExistence(timeout: 10), "Article detail view should exist")
            
            let readMoreLink = app.buttons[AccessibilityIdentifier.readMoreLink] // Replace with the actual title or accessibility identifier
            XCTAssertTrue(readMoreLink.waitForExistence(timeout: 10), "Read More Link should exist")
            readMoreLink.tap()
            
            let backButton = app.navigationBars.buttons.element(boundBy: 0)
            XCTAssertTrue(backButton.waitForExistence(timeout: 10), "Back button should exist")
            backButton.tap()
            
        } else {
            XCTFail("No articles found to test the artcile detail view functionality")
        }
    }
    
    func testBookmarkTabUI() {
        // Launch the app
        let app = XCUIApplication()
        app.launch()
        
        print(app.debugDescription)
        sleep(5)  // Add a small delay to let the UI load
        
        // Verify that the tabBar exists
        let tabBar = app.otherElements[AccessibilityIdentifier.tabBar]
        XCTAssertTrue(tabBar.waitForExistence(timeout: 10), "Tab bar should exist")
        
        // Verify the "Bookmark" tab button exists
        let bookmarkTabButton = tabBar.buttons.element(boundBy: 1)  // Second tab (Bookmark)
        XCTAssertTrue(bookmarkTabButton.waitForExistence(timeout: 10), "Bookmark tab button should exist")
        
        // Tap the "Bookmark" tab
        bookmarkTabButton.tap()
        
        // Verify the content for the "Bookmark" tab
        let bookmarkListView = app.staticTexts[AccessibilityIdentifier.bookmarkListView] // Assuming you have this identifier set
        XCTAssertTrue(bookmarkListView.waitForExistence(timeout: 20), "Bookmark List View should appear after tapping the Bookmark tab")
    }
    
    func testNoBookmarkViewUI() {
        // Launch the app
        let app = XCUIApplication()
        app.launch()
        sleep(5)  // Add a small delay to let the UI load
        print(app.debugDescription)
        
        // Verify that the tabBar exists
        let tabBar = app.otherElements[AccessibilityIdentifier.tabBar]
        XCTAssertTrue(tabBar.waitForExistence(timeout: 10), "Tab bar should exist")
        
        // Verify the "Bookmark" tab button exists
        let bookmarkTabButton = tabBar.buttons.element(boundBy: 1)  // Second tab (Bookmark)
        XCTAssertTrue(bookmarkTabButton.waitForExistence(timeout: 10), "Bookmark tab button should exist")
        
        // Tap the "Bookmark" tab
        bookmarkTabButton.tap()
        
        // Verify the content for the "Bookmark" tab
        let bookmarkListView = app.staticTexts[AccessibilityIdentifier.bookmarkListView] // Assuming you have this identifier set
        XCTAssertTrue(bookmarkListView.waitForExistence(timeout: 20), "Bookmark List View should appear after tapping the Bookmark tab")
        
        let articleCells = app.cells
        let cellCount = articleCells.count
        
        // Assert that no articles are bookmarked
        if cellCount == 0 {
            let noBookmarksMessage = app.staticTexts["You haven’t bookmarked any articles yet. Browse and bookmark your favorites!"]
            XCTAssertTrue(noBookmarksMessage.waitForExistence(timeout: 10), "No bookmarks message should be visible when no articles are bookmarked")
        } else {
            XCTFail("Bookmark list is not empty; test intended for empty state only")
        }
    }
}
