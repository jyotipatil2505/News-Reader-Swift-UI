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
    
    static func convertModelToDictionary<T: Encodable>(_ object: T) -> [String: Any]? {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(object)
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                return jsonObject
            }
        } catch {
            print("Error converting object to dictionary: \(error)")
        }
        return nil
    }
}
