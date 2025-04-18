//
//  APIError.swift
//  Capitals
//
//  Created by Imran shaik on 18/04/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unknown(Error)
}
