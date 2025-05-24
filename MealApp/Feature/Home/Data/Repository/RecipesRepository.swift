//
//  RecipesRepository.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import Foundation
import Factory

protocol RecipesRepositoryProtocol {
    func getAllRecipies(recipesRequest: RecipiesRequest, completion: @escaping (Result<RecipesResponse, Error>) -> Void)
}

class RecipesRepository: RecipesRepositoryProtocol {
    @Injected(\.recipiesRemoteDS) private var recipiesRemoteDS
    
    func getAllRecipies(recipesRequest: RecipiesRequest, completion: @escaping (Result<RecipesResponse, any Error>) -> Void) {
        recipiesRemoteDS.getAllRecipies(recipesRequest: recipesRequest) { result in
            switch result {
                case .success(let recipies):
                    completion(.success(recipies))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
