//
//  GetCategoriesUseCase.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 12/05/2025.
//

import Foundation
import Factory

protocol GetCategoriesUseCaseProtocol {
    func execute(categoryRequest: CategoryRequest, completion: @escaping (Result<CategoryResponse, Error>) -> Void)
}

class GetCategoriesUseCase: GetCategoriesUseCaseProtocol {
    @Injected(\.categoriesRepository) private var categoriesRepository
    
    func execute(categoryRequest: CategoryRequest, completion: @escaping (Result<CategoryResponse, any Error>) -> Void) {
        categoriesRepository.getAllRecipies(categoryRequest: categoryRequest) { result in
            completion(result)
        }
    }
}
