//
//  ResultState.swift
//  WeatherApp
//
//  Created by Vinsi on 29/07/2021.
//

import Foundation

enum ResultState<T> {
    case loading
    case success(content: T)
    case failed(error: Error)
}
