//
//  FlowCoordinator.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation
import SwiftUI
/// The FlowCoordinator class is responsible for managing the app's flow.
final class FlowCoordinator {

    private let appContainer: AppContainer
    
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
    }
    
    /// The start() method is the entry point of the app flow. It decides what to display based on the app's state (e.g., login flow, main content, etc.).
    /// In this case, it initializes the news scene container and starts the news flow coordinator.
    func start() -> some View {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let container = appContainer.makeNewsSceneContainer()
        let flow = container.makeNewsFlowCoordinator()
        return flow.start()
    }
}
