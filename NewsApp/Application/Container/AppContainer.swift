//
//  Container.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

final class AppContainer {
    // MARK: - Network
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
    func makeNewsSceneContainer() -> NewsReaderSceneContainer {
        let dependencies = NewsReaderSceneContainer.Dependencies(networkService: networkServiceManager)
        return NewsReaderSceneContainer(dependencies: dependencies)
    }
}
