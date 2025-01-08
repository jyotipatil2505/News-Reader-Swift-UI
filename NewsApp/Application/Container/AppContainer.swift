//
//  Container.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

/// This class, AppContainer, serves as a central point for managing dependencies and the configuration of various components in the application.
/// Specifically, it is responsible for handling the network service manager and creating scene containers that manage different parts of the application.
final class AppContainer {
    
    // MARK: - Network
    /// The lazy-initialized instance of networkServiceManager ensures that network services are only set up when required.
    lazy var networkServiceManager: NetworkServiceProtocol = {
        let config = NetworkConfig(
            baseURL: URL(string: EnvironmentConfiguration.developmentUrl)!,
            queryParameters: [
                "apiKey": EnvironmentConfiguration.developmentApiKey,
                "country": "us"
            ]
        )
        return NetworkService(config: config)
    }()
    
    // MARK: - Containers of scenes
    /// This function is used to create and return an instance of NewsReaderSceneContainer, which is responsible for managing the news-related scenes in the app.
    func makeNewsSceneContainer() -> NewsReaderSceneContainer {
        let dependencies = NewsReaderSceneContainer.Dependencies(networkService: networkServiceManager)
        return NewsReaderSceneContainer(dependencies: dependencies)
    }
}
