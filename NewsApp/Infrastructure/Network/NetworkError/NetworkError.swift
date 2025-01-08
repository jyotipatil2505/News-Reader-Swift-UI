//
//  NetworkError.swift
//  NewsApp
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

/// NetworkError is an enumeration that defines various error types related to network operations in the app. It conforms to both Error and LocalizedError protocols, providing meaningful error messages for each case.
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case requestFailed(statusCode: Int) // Include HTTP status codes
    case timeout
    case noInternet // New case for internet connectivity issues
    case serverError
    case error4xx(_ code: Int)
    case error5xx(_ code: Int)
    case unknownError // Catch-all for unexpected errors
    case decodableFailure(Error)
    case urlSessionFailed(_ error: URLError)
    case badInput
    case requestGenerationError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .badRequest:
            return "The request was malformed."
        case .unauthorized:
            return "You are not authorized to access this resource."
        case .forbidden:
            return "You are not allowed to access this resource."
        case .notFound:
            return "The resource you requested was not found."
        case .requestFailed(let statusCode):
            return "Network request failed with status code \(statusCode)."
        case .decodableFailure(let error):
            return "Decoding failed with error: \(error)"
        case .serverError:
            return "The server encountered an error."
        case .timeout:
            return "The request timed out. Please try again."
        case .noInternet:
            return "No internet connection. Please check your network settings and try again."
        case .error4xx(let code):
            return "Server returned an error with status code \(code)."
        case .error5xx(let code):
            return "Server returned an error with status code \(code)."
        case .urlSessionFailed(let error):
            return "URL session failed with error: \(error)"
        case .unknownError:
            return "An unknown error occurred."
        case .badInput:
            return "Bad input."
        case .requestGenerationError:
            return "Request generation failed."
        }
    }
}


