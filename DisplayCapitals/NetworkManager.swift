//
//  NetworkManager.swift
//  Capitals
//
//  Created by Imran shaik on 18/04/25.
//


import Foundation

/// Network manager to handle all the API calls
class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}

    
    /// Method to fetch the data
    /// - Parameters:
    ///   - urlString: URL to place the API call
    ///   - completion: Handle Success or Error scenarios
    ///
    func fetchData<T: Codable>(from urlString: String, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(.invalidURL))
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                return completion(.failure(.unknown(error)))
            }

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                return completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
            }

            guard let data = data else {
                return completion(.failure(.noData))
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
