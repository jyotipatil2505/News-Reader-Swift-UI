//
//  APIManager.swift
//  NewsApp
//
//  Created by Jyoti Patil on 21/10/24.
//

import Foundation

class APIManager {
    static let shared = APIManager()

    private init() {}

    func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: endpoint.baseUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            print("data :::: ",data)
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch let error {
                print("error ::::: ",error)
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
