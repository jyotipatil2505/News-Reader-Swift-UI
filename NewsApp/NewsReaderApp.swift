//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import SwiftUI

@main
struct NewsReaderApp: App {
    let mainFlowCoordinator = FlowCoordinator(appContainer: AppContainer())

    var body: some Scene {
        WindowGroup {
            mainFlowCoordinator.start() // Start the flow
        }
    }
}
