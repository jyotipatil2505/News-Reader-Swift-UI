//
//  Helpers.swift
//  NewsReader
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

struct Utilities {
    static func debugPrint(log: String) {
#if DEBUG
        print(log)
#endif
    }
}
