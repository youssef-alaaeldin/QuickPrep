//
//  MockRecipiesRepository.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 24/05/2025.
//

import Foundation

final class MockRecipiesRepository: RecipesRepositoryProtocol {
    var result: Result<RecipesResponse, Error>?

    func getAllRecipies(recipesRequest: RecipiesRequest, completion: @escaping (Result<RecipesResponse, Error>) -> Void) {
        guard let result = result else {
            fatalError("Result must be set before calling use case")
        }
        completion(result)
    }
}
