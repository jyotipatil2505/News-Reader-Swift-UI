import SwiftUI

/// Protocol NewsFlowCoordinatorDependencies:
/// Defines two associated types: NewsListViewType and BookmarkViewType, both conforming to View.
/// Provides methods to create the news list and bookmark views.
protocol NewsFlowCoordinatorDependencies  {
    associatedtype NewsListViewType: View
    associatedtype BookmarkViewType: View
    func makeNewsListView() -> NewsListViewType
    func makeBookmarkView() -> BookmarkViewType
}

/// Class NewsSceneFlowCoordinator:
/// Generic over a type conforming to NewsFlowCoordinatorDependencies.
/// Coordinates the news flow by constructing views through its dependencies.
final class NewsSceneFlowCoordinator<Dependencies: NewsFlowCoordinatorDependencies> {
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    /// The start() method returns a MainView, combining the dynamically created news list and bookmark views.
    func start() -> some View {
        MainView(newsView: AnyView(dependencies.makeNewsListView()), bookmarkView: AnyView(dependencies.makeBookmarkView()))
    }
}
