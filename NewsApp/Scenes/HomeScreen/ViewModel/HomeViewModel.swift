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
    
    private let articleRepository: ArticleRepository
    private(set) var articles = [NewsResponse.Result]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState<[NewsResponse.Result]> = .loading
    
    init(articleRepository: ArticleRepository) {
        self.articleRepository = articleRepository
    }
    
    func getArticles() {
        self.state = .loading
        let cancellable = articleRepository.getAll()
            .sink { (res) in
                switch res {
                case .finished:
                    self.state = .success(content: self.articles)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { articles in
                self.articles = articles
            }
        self.cancellables.insert(cancellable)
    }
}
