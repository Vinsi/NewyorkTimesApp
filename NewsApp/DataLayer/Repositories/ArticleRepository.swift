//
//  ArticleRepository.swift
//  NewsApp
//
//  Created by Vinsi on 02/08/2021.
//

import Foundation
import Combine

struct ArticleRepository: RepositoryType {
    
    typealias OutputType = [NewsResponse.Result]
    let newService: NewsServiceImpl
    func getAll() -> AnyPublisher<[NewsResponse.Result], RepoError> {
        newService.request(from: .init(parameter: .mostViewed(section: .allSections, days: .sevenDaysAgo))).compactMap(\.results)
            .mapError({ err in RepoError.serverError(ApiError: err)})
            .eraseToAnyPublisher()
    }
}

