//
//  String.swift
//  NewsAPIKit
//
//  Created by Jyoti Patil on 07/01/25.
//
import Foundation

extension String {
    func asURL() throws -> URL {
        guard let url = URL(string: self) else { throw NetworkError.invalidURL }
        return url
    }
}
