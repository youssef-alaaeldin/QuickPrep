//
//  CategoriesRemoteDS.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 12/05/2025.
//

import Foundation
import Factory

class CategoriesRemoteDataSource: CategoriesRemoteDataSourceProtocol {
    @Injected(\.networkProvider) private var networkProvider
    var categoriesTask: Task<Void, Never>?
    
    func getAllRecipies(categoryRequest: CategoryRequest, completion: @escaping (Result<CategoryResponse, any Error>) -> Void) {
        categoriesTask = Task {
            do {
                let result = try await networkProvider.get(endpoint: categoryRequest, responseType: CategoryResponse.self)
                guard !Task.isCancelled else {
                    print("Task cancelled")
                    return
                }
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
}

