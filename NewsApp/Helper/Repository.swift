//
//  Repository.swift
//  NewsApp
//
//  Created by Vinsi on 02/08/2021.
//

import Foundation
protocol RepositoryType {
    associatedtype Result
    typealias RepoResultCallBack = (Bool, Result) -> ()
    func getAll(onCompletion: @escaping RepoResultCallBack)
    func get(for param: Any, onCompletion: @escaping RepoResultCallBack)
    func deleteAll()
}

extension RepositoryType {
    
    func getAll(onCompletion: @escaping RepoResultCallBack) {
        fatalError("Not implemented")
    }
    func get(for param: Any, onCompletion: @escaping RepoResultCallBack) {
        fatalError("Not implemented")
    }
    func deleteAll() {
        fatalError("Not implemented")
    }
    
}
