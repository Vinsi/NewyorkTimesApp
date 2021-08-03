//
//  APIError.swift
//  WeatherApp
//
//  Created by Vinsi on 29/07/2021.
//

import Foundation

enum APIError: Error {
    
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .unknown:
            return "unknown"
        }
    }
}
