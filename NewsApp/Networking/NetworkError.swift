//
//  NetworkError.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .requestFailed:
            return "Network request failed."
        case .decodingError:
            return "Failed to decode the response."
        }
    }
}
