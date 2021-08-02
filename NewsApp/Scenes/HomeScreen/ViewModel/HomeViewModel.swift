//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Vinsi on 01/08/2021.
//

import Foundation
import Combine

protocol NewsViewModel {
    func getArticles()
}

class NewsViewModelImpl: ObservableObject, NewsViewModel {
    
    private let service: NewsService
    
    private(set) var articles = [Result]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState<[Result]> = .loading
    
    init(service: NewsService) {
        self.service = service
    }
    
    func getArticles() {
        self.state = .loading
        let cancellable = service
            .request(from: .init(parameter: .mostViewed(section: .allSections, days: .sevenDaysAgo)))
            .sink { (res) in
                switch res {
                case .finished:
                    self.state = .success(content: self.articles)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { (response) in
                self.articles = response.results ?? []
            }
        self.cancellables.insert(cancellable)
    }
}
