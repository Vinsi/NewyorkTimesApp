//
//  APIBuilder.swift
//  WeatherApp
//
//  Created by Vinsi on 29/07/2021.
//

struct NewsAPI: APIBuilder {

    var method: HttpMethod = HttpMethod.get
    
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
