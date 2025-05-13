//
//  RecipesRemoteDataSource.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import Foundation
import Factory

protocol RecipesRemoteDataSourceProtocol {
    func getAllRecipies(recipesRequest: RecipiesRequest, completion: @escaping (Result<RecipesResponse, Error>) -> Void)
}

class RecipesRemoteDataSource: RecipesRemoteDataSourceProtocol {
    @Injected(\.networkProvider) private var networkProvider
    
    func getAllRecipies(recipesRequest: RecipiesRequest, completion: @escaping (Result<RecipesResponse, any Error>) -> Void) {
        Task {
            do {
                let result = try await networkProvider.get(endpoint: recipesRequest, responseType: RecipesResponse.self)
                
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
