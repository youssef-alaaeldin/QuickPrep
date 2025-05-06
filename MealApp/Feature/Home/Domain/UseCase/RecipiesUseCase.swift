//
//  RecipiesUseCase.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import Foundation
import Factory

protocol RecipiesUseCaseProtocol {
    func exectute(recipiesRequest: RecipiesRequest, completion: @escaping (Result<Recipes, Error>) -> Void)
}

class RecipiesUseCase: RecipiesUseCaseProtocol {
    @Injected(\.recipiesRepository) private var recipiesRepository
    
    func exectute(recipiesRequest: RecipiesRequest, completion: @escaping (Result<Recipes, any Error>) -> Void) {
        recipiesRepository.getAllRecipies(recipesRequest: recipiesRequest) { result in
            switch result {
                case .success(let recipies):
                    completion(.success(recipies))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
