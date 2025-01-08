import UIKit
import SwiftUI

final class NewsReaderSceneContainer: NewsFlowCoordinatorDependencies {
    
    typealias NewsListViewType = NewsListView
    typealias BookmarkViewType = BookmarkView
    
    struct Dependencies {
        let networkService: NetworkServiceProtocol
    }
    
    private let dependencies: Dependencies

    // MARK: - Persistent Storage
    lazy var newsResponseStorage: NewsResponseStorage = NewsResponseStorageImpl()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies        
    }
    
    //Mark: - Repositroy
    func makeNewsRepository() -> NewsRepositoryProtocol {
        NewsRepository(networkService: dependencies.networkService, localStorage: newsResponseStorage)
    }
    
    // MARK: - Common Use Cases
    func makeNewsUseCase() -> FetchNewsUseCaseProtocol {
        FetchNewsUseCase(repository: makeNewsRepository())
    }
 
    // MARK: - Common ViewModel
    func makeNewsListViewModel() -> NewsViewModelProtocol {
        NewsViewModel(newsUseCase: makeNewsUseCase())
    }

    // MARK: - NewsList View
    func makeNewsListView() -> NewsListViewType {
        NewsListView(viewModelWrapper: self.makeNewsListViewModelWrapper())
    }
    
    func makeNewsListViewModelWrapper() -> NewsListViewModelWrapper {
        NewsListViewModelWrapper(viewModel: makeNewsListViewModel())
    }
    
    // MARK: - BookMarkView
    func makeBookmarkViewModelWrapper() -> BookmarkViewModelWrapper {
        BookmarkViewModelWrapper(viewModel: makeNewsListViewModel())
    }
    
    func makeBookmarkView() -> BookmarkViewType {
        BookmarkView(viewModelWrapper: self.makeBookmarkViewModelWrapper())
    }

    // MARK: - Flow Coordinators
    func makeNewsFlowCoordinator() -> NewsSceneFlowCoordinator<NewsReaderSceneContainer> {
        NewsSceneFlowCoordinator(dependencies: self)
    }
}
