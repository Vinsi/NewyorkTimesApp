//
//  APIBuilder.swift
//  WeatherApp
//
//  Created by Vinsi on 29/07/2021.
//

import Foundation

protocol APIBuilder {
    
    var urlRequest: URLRequest { get }
    var baseURL: String { get }
    var path: String { get }
    var query: [String: String] { get }
    
}

extension  APIBuilder {
    
    var urlRequest: URLRequest {
        let param = query.reduce("", {
            "\($0)&\($1.key)=\($1.value)"
        })
        let url = "https://\(baseURL)/\(path)?\(param)"
        return URLRequest(url:  URL(string: url)!)
    }
}

struct NewsAPI: APIBuilder {
    
    var query: [String: String] {
        guard let token = key else {
            fatalError("token empty")
        }
        return [ "api-key": token]
    }
    var version: Version = .v2
    var type: ResponseType = .json
    var parameter: Parameter
    private let key: String? = Configuration.value(for: .nytToken)
    let baseURL: String = Configuration.value(for: .nytBaseURL)!
    
    var path: String {
        
        let basePath = "svc/mostpopular"
        switch parameter {
        case .mostViewed(let section, let days):
            return [ basePath,
                     version.rawValue,
                     parameter.path,
                     section.rawValue,
                     "\(days.rawValue).\(type.rawValue)"
            ].joined(separator: "/")
        }
    }
}

// MARK:- Types
extension NewsAPI {
    
    enum Version: String {
        case v1
        case v2
    }
    
    enum Section: String {
        
        case allSections = "all-sections"
        case others
    }
    
    enum Period: Int {
        case oneDayAgo = 1
        case sevenDaysAgo = 7
        case thirtyDaysAgo = 30
    }
    
    enum Parameter {
        case mostViewed(section: Section, days: Period)
        var path: String {
            "mostviewed"
        }
    }
    
    enum ResponseType: String {
        case json
    }
}
