//
//  Helpers.swift
//  NewsReader
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

struct Utilities {
    
    /// This function logs messages only when the app is running in Debug mode.
    static func debugPrint(log: String) {
#if DEBUG
        print(log)
#endif
    }
}
