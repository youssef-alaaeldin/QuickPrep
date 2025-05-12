//
//  CategoriesRemoteDataSourceProtocol.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 12/05/2025.
//

import Foundation

protocol CategoriesRemoteDataSourceProtocol {
    func getAllRecipies(categoryRequest: CategoryRequest, completion: @escaping (Result<CategoryResponse, Error>) -> Void)
}
