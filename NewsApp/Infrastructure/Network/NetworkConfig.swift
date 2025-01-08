//
//  NetworkConfig.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

/// The NetworkConfigurable protocol defines the blueprint for network configuration objects in the application.
/// It ensures that any type conforming to this protocol will provide the necessary properties to configure network requests.
protocol NetworkConfigurable {
    var baseURL: URL { get }
    var headers: HTTPHeaders { get }
    var queryParameters: Parameters { get }
}

/// The NetworkConfig struct provides a configuration setup for network requests.
struct NetworkConfig: NetworkConfigurable {
    
    /// The root URL for network requests.
    let baseURL: URL
    
    /// Optional HTTP headers (defaults to an empty dictionary).
    let headers: HTTPHeaders
    
    /// The query parameters to be sent with requests.
    let queryParameters: Parameters
    
     init(
        baseURL: URL,
        headers: [String: String] = [:],
        queryParameters: Parameters
     ) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
