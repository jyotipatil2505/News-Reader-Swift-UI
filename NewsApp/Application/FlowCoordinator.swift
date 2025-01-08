//
//  FlowCoordinator.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation
import SwiftUI

final class FlowCoordinator {

    private let appContainer: AppContainer
    
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
    }

    func start() -> some View {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let container = appContainer.makeNewsSceneContainer()
        let flow = container.makeNewsFlowCoordinator()
        return flow.start()
    }
}
