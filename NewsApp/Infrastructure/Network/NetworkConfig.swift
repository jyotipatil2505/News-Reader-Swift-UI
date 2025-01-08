//
//  NetworkConfig.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

protocol NetworkConfigurable {
    var baseURL: URL { get }
    var headers: HTTPHeaders { get }
    var queryParameters: Parameters { get }
}

struct NetworkConfig: NetworkConfigurable {
    let baseURL: URL
    let headers: HTTPHeaders
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
