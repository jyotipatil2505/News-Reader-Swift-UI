////
////  Endpoints.swift
////  NewsApp
////
////  Created by Jyoti Patil on 07/01/25.
////

import Foundation

/// The Endpoint class is designed to represent a network request, conforming to the NetworkRequestType protocol.
/// It encapsulates information about the request, including the URL path, HTTP method, query parameters, body parameters, headers, and the body encoder used to encode the parameters.
class Endpoint: NetworkRequestType {
    var path: String
    var httpMethod: HTTPMethod
    var queryParameters: Parameters
    var bodyParameters: Parameters
    var headers: HTTPHeaders
    let bodyEncoder: BodyEncoder
    
    init(path: String,
         isFullPath: Bool = false,
         method: HTTPMethod,
         headerParameters: HTTPHeaders = [:],
         queryParameters: Parameters = [:],
         bodyParameters: Parameters = [:]) {
        
        self.path = path
        self.httpMethod = method
        self.bodyParameters = bodyParameters
        self.queryParameters = queryParameters
        self.headers = headerParameters
        self.bodyEncoder = JSONBodyEncoder()
    }
}

/// The BodyEncoder protocol defines the requirement for encoding body parameters into data that can be sent over a network.
protocol BodyEncoder {
    func encode(_ parameters: [String: Any]) -> Data?
}

/// JSONBodyEncoder is a concrete implementation of the BodyEncoder protocol. It encodes the given parameters into JSON data using JSONSerialization.
struct JSONBodyEncoder: BodyEncoder {
    func encode(_ parameters: [String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: parameters)
    }
}
