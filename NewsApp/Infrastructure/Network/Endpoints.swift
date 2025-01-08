////
////  Endpoints.swift
////  NewsApp
////
////  Created by Jyoti Patil on 07/01/25.
////
//
//import Foundation
//
//enum Endpoint {
//    case topHeadlines
//    case everything
//}
//
//extension Endpoint: NetworkRequestType {
//
//    var path: String {
//        switch self {
//        case .topHeadlines:
//            return "/v2/top-headlines"
//        case .everything:
//            return "v2/everything"
//        }
//    }
//    
//    var httpMethod: HTTPMethod {
//        switch self {
//        case .topHeadlines:
//            return .GET
//        case .everything:
//            return .GET
//        }
//    }
//    
//    public var parameters: RequestParams? {
//        switch self {
//        case .topHeadlines:
//            return nil
//        case .everything:
//            return nil
//        }
//    }
//    
//    // Headers for each case
//    var headers: HTTPHeaders {
//        return ["Content-Type":"application/json"]
//    }
//}

import Foundation

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

protocol BodyEncoder {
    func encode(_ parameters: [String: Any]) -> Data?
}

struct JSONBodyEncoder: BodyEncoder {
    func encode(_ parameters: [String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: parameters)
    }
}

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}
