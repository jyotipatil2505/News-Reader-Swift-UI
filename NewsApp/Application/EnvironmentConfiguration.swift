//
//  Configuration.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation
/// The EnvironmentConfiguration class provides static configuration settings for different environments (development, staging, and production) in the app.
final class EnvironmentConfiguration {
    
    /// Base URL for the development environment.
    static let developmentUrl: String = "https://newsapi.org"
    
    /// Base URL for the staging environment.
    static let stagingUrl: String = "https://newsapi.org"
    
    /// Base URL for the production environment.
    static let productionUrl: String = "https://newsapi.org"
    
    /// API key for the development environment.
    static let developmentApiKey: String = "86b66100d74c45818521c1eb95151c12"
    
    /// API key for the staging environment.
    static let stagingApiKey: String = "86b66100d74c45818521c1eb95151c12"
    
    /// API key for the production environment.
    static let productionApiKey: String = "86b66100d74c45818521c1eb95151c12"
}
