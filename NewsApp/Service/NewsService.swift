//
//  NewsService.swift
//  NewsApp
//
//  Created by Vinsi on 29/07/2021.
//

import Foundation
import Combine

protocol Service { }

extension Service {
    
    func request<T:APIBuilder, R: Codable>(from endpoint: T, responseType: R.Type) -> AnyPublisher<R, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<R, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    //jsonDecoder.dateDecodingStrategy = .iso8601
                    return Just(data)
                        .decode(type: R.self, decoder: jsonDecoder)
                        .mapError { _ in
                            APIError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

struct NewsServiceImpl: Service {
    
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError> {
         request(from: endpoint, responseType: NewsResponse.self)
    }
}
