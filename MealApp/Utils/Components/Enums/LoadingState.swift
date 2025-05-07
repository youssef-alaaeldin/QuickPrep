//
//  LoadingState.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 07/05/2025.
//

import Foundation

enum LoadingState<T> {
    case loading
    case reloading
    case idle
    case loaded(T?)
    case error
}
