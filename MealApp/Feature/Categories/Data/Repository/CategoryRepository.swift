//
//  CategoryRepository.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 12/05/2025.
//

import Foundation
import Factory

class CategoryRepository: CategoryRepositoryProtocol {
    @Injected(\.categoriesRemoteDS) private var categoriesRemoteDS
    
    func getAllRecipies(categoryRequest: CategoryRequest, completion: @escaping (Result<CategoryResponse, any Error>) -> Void) {
        categoriesRemoteDS.getAllRecipies(categoryRequest: categoryRequest) { result in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
