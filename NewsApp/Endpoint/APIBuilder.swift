//
//  APIBuilder.swift
//  WeatherApp
//
//  Created by Vinsi on 29/07/2021.
//

import Foundation

protocol APIBuilder {
    
    var urlRequest: URLRequest { get }
    var baseURL: URL { get }
    var path: String { get }
    var query: String { get }

}

struct OpenWeatherMapAPI: APIBuilder {
    
    enum Parameter {
        case forcast(city: String)
        case current(cityId: String)
       
        
    }
    
    var version: String {
        "2.5"
    }
    
    var urlRequest: URLRequest {
        
    }
    
    
    var url: String {
        [AppConfiguration.shared.selectedEnvironment.apiPath,
         version].joined(separator: "/")
    }
    
    var queryParameter: String {
        var params = [String:String]()
        params["appid"] = AppConfiguration.shared.selectedEnvironment.token
        params["units"] = "metric"
        
        switch self {
        case .forcast(let city):
            params["q"] = city
        case .current( let cityID):
            params["id"] = cityID
        }
        return params.reduce("") {
            $0 + "\($1.0)=\($1.1)&"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: url + "?" + queryParameter) else {
            fatalError("baseURL not found")
        }
        return url
    }
    
    var path: String {
        return "forecast"
    }
    
    var headers: [String : String]? {
        return ["ContentType": "application/json"]
    }
}
