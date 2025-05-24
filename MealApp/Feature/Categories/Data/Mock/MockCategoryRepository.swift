//
//  MockCategoryRepository.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 24/05/2025.
//

import Foundation

final class MockCategoryRepository: CategoryRepositoryProtocol {
    var result: Result<CategoryResponse, Error>?

    func getAllRecipies(categoryRequest: CategoryRequest, completion: @escaping (Result<CategoryResponse, Error>) -> Void) {
        guard let result = result else {
            fatalError("MockCategoryRepository result must be set before calling")
        }
        completion(result)
    }
}
