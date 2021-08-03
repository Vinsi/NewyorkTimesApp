//
//  NewsService.swift
//  NewsApp
//
//  Created by Vinsi on 29/07/2021.
//

import Foundation
import Combine

struct NewsServiceImpl: Service {
    
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError> {
         request(from: endpoint, responseType: NewsResponse.self)
    }
}
