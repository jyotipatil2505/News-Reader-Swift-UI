//
//  LocalStorageError.swift
//  NewsReader
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

/// The LocalStorageError enum defines possible errors related to local storage operations
enum LocalStorageError: Error {
    
    /// Error when initializing the local storage.
    case realmInitializationFailed
    
    /// Error when the requested object is not found in local storage.
    case objectNotFound
    
    /// Error when data fails to be saved.
    case failedToSave
    
    /// Error when the provided data is invalid for storage.
    case invalidData
    
    /// Each case includes a localizedDescription property to provide a human-readable error message.
    var localizedDescription: String {
        switch self {
        case .realmInitializationFailed:
            return "There was an issue initializing the local storage."
        case .objectNotFound:
            return "The requested object was not found in the local storage."
        case .failedToSave:
            return "Failed to save the data to local storage."
        case .invalidData:
            return "The data provided is invalid for storage."
        }
    }
}
