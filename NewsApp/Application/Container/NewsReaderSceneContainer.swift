import UIKit
import SwiftUI

final class NewsReaderSceneContainer: NewsFlowCoordinatorDependencies {
    
    /// Type aliases for the views used in the scene.
    typealias NewsListViewType = NewsListView
    typealias BookmarkViewType = BookmarkView
    
    /// A container for the dependencies that the scene relies on, such as the networkService, which is of type NetworkServiceProtocol.
    /// This allows for better decoupling and makes it easier to inject different implementations of NetworkServiceProtocol
    struct Dependencies {
        let networkService: NetworkServiceProtocol
    }
    
    private let dependencies: Dependencies

    // MARK: - Persistent Storage
    /// A lazy-initialized instance of NewsResponseStorageImpl, which is responsible for storing and fetching the news data.
    /// Lazy initialization ensures that the storage is created only when it’s needed.
    lazy var newsResponseStorage: NewsResponseStorage = NewsResponseStorageImpl()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies        
    }
    
    //Mark: - Repositroy
    /// Creates and provides a NewsRepository instance that interacts with the network service and local storage.
    func makeNewsRepository() -> NewsRepositoryProtocol {
        NewsRepository(networkService: dependencies.networkService, localStorage: newsResponseStorage)
    }
    
    // MARK: - Common Use Cases
    /// Creates the FetchNewsUseCase which uses the repository to handle the business logic related to fetching news.
    func makeNewsUseCase() -> FetchNewsUseCaseProtocol {
        FetchNewsUseCase(repository: makeNewsRepository())
    }
 
    // MARK: - ViewModel
    /// Creates and provides a NewsViewModel, which contains the business logic and state management for the news list view, bookmark view.
    func makeNewsListViewModel() -> NewsViewModelProtocol {
        NewsViewModel(newsUseCase: makeNewsUseCase())
    }

    // MARK: - NewsListView
    /// Returns a NewsListView, which displays the list of news articles.
    func makeNewsListView() -> NewsListViewType {
        NewsListView(viewModelWrapper: self.makeNewsListViewModelWrapper())
    }
    
    /// The makeNewsListViewModelWrapper() function creates and returns an instance of NewsListViewModelWrapper, which wraps the NewsViewModel.
    func makeNewsListViewModelWrapper() -> NewsListViewModelWrapper {
        NewsListViewModelWrapper(viewModel: makeNewsListViewModel())
    }
    
    // MARK: - BookMarkView
    /// The makeNewsListViewModelWrapper() function creates and returns an instance of BookmarkViewModelWrapper, which wraps the NewsViewModel.
    func makeBookmarkViewModelWrapper() -> BookmarkViewModelWrapper {
        BookmarkViewModelWrapper(viewModel: makeNewsListViewModel())
    }
    
    /// Returns a BookmarkView, which displays bookmarked news articles.
    func makeBookmarkView() -> BookmarkViewType {
        BookmarkView(viewModelWrapper: self.makeBookmarkViewModelWrapper())
    }
    
    // MARK: - Flow Coordinators
    /// Creates and returns a flow coordinator that manages navigation between different views/screens in the NewsReader feature.
    func makeNewsFlowCoordinator() -> NewsSceneFlowCoordinator<NewsReaderSceneContainer> {
        NewsSceneFlowCoordinator(dependencies: self)
    }
}
