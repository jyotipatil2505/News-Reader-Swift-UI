//
//  APIManager.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

/// The NetworkServiceProtocol defines the contract that the NetworkService class must adhere to for handling network requests.
/// The protocol focuses on abstracting the request process and ensuring that any conforming class can handle requests in a consistent manner.
protocol NetworkServiceProtocol: AnyObject {
    
    /// The request method is responsible for making a network request, decoding the response into the specified type T, and handling errors.
    func request<T: Decodable>(request: any NetworkRequestType, type: T.Type, decodingType: JSONDecoder.KeyDecodingStrategy) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    
    /// An instance of JSONDecoder used to decode the response data into the expected model type.
    private var decoder: JSONDecoder = JSONDecoder()
    
    /// A NetworkConfigurable object that holds the configuration for network requests, including the base URL and headers.
    private let config: NetworkConfigurable
        
    /// A custom URLSession with a timeout configuration for network requests. It has a timeout of 60 seconds for both requests and resources.
    private var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60 // Request timeout (seconds)
        configuration.timeoutIntervalForResource = 60 // Resource timeout (seconds)
        return URLSession(configuration: configuration)
    }()
    
    init(config: NetworkConfigurable) {
        self.config = config
    }
    
    /// Makes an asynchronous network request, decodes the response, and returns the result.
    func request<T: Decodable>(request: any NetworkRequestType, type: T.Type, decodingType: JSONDecoder.KeyDecodingStrategy) async throws -> T {
        // Check for Internet Connectivity
        guard Reachability.isConnectedToNetwork() else {
            throw NetworkError.noInternet
        }
        
        // Assign Decoding Strategy
        self.decoder.keyDecodingStrategy = decodingType
        
        // Create URLRequest
        let networkRequest: URLRequest
        do {
            networkRequest = try request.prepareURLRequest(config: config, requestType: request)
        } catch {
            throw NetworkError.badRequest
        }
        
        Utilities.debugPrint(log: "networkRequest :::: \(networkRequest)")
        
        // Perform the network request
        do {
            let (data, response) = try await session.data(for: networkRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknownError
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                return try decoder.decode(T.self, from: data)
            default:
                throw self.httpError(statusCode: httpResponse.statusCode)
            }
            
        } catch {
            throw self.handleError(error: error)
        }
    }
    
    /// Maps the HTTP status code to a corresponding NetworkError.
    private func httpError(statusCode: Int) -> NetworkError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }
    
    /// Handles various types of errors that can occur during the network request and converts them into a NetworkError.
    private func handleError(error: Error) -> NetworkError {
        switch error {
        case is Swift.DecodingError:
            if let decodingError = error as? DecodingError {
                return .decodableFailure(decodingError)
            }
            return .decodableFailure(error)
        case let urlError as URLError:
            if urlError.code == .timedOut {
                return .timeout
            }
            return .urlSessionFailed(urlError)
        case let error as NetworkError:
            return error
        default:
            return .unknownError
        }
    }
}

