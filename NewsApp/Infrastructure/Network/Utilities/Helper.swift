//
//  Utilities.swift
//  NewsAPIKit
//
//  Created by Jyoti Patil on 07/01/25.
//

import Foundation

struct Helper {
    static func debugPrint(log: String) {
#if DEBUG
        print(log)
#endif
    }
}
