//
//  Repository.swift
//  NewsApp
//
//  Created by Vinsi on 02/08/2021.
//
import Foundation
import Combine

enum RepoError: Error {
  case serverError(ApiError: APIError)
  case localStorageError
}

protocol RepositoryType {
    
    associatedtype OutputType
    func getAll() -> AnyPublisher<OutputType,RepoError>
    func get(for param: Any) -> AnyPublisher<OutputType,RepoError>
    func deleteAll()
}

extension RepositoryType {
    
    func getAll() -> AnyPublisher<OutputType,RepoError> {
        fatalError("Not implemented")
    }
    
    func get(for param: Any) -> AnyPublisher<OutputType,RepoError>{
        fatalError("Not implemented")
    }
    
    func deleteAll() {
        fatalError("Not implemented")
    }
}
