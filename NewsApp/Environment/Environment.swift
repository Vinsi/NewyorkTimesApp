//
//  Environment.swift
//  NewsApp
//
//  Created by Vinsi on 01/08/2021.
//

import Foundation

enum AppEnvironment {
    
    case uat
    case qa
    case prod
}

enum Configuration {
    
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
   
    static var environment: AppEnvironment {
        #if PROD
        return .prod
        #elseif QA
        return .qa
        #else
        return .uat
        #endif
    }
}

extension Configuration {
    
    enum Keys: String {
        case nytBaseURL = "NYTIMES_BASE_URL"
        case nytToken = "NYTIMES_TOKEN"
    }
    
    static func value(for key: Keys) -> String? {
         try? value(for: key.rawValue)
    }
}
