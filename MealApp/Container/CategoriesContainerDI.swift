//
//  CategoriesContainerDI.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 12/05/2025.
//

import Foundation
import Factory


extension Container {
    // MARK: Remote Data Source
    var categoriesRemoteDS: Factory<CategoriesRemoteDataSourceProtocol> {
        Factory(self) {
            CategoriesRemoteDataSource()
        }
    }
    
    // MARK: - Repository
    
    var categoriesRepository: Factory<CategoryRepositoryProtocol> {
        Factory(self) {CategoryRepository()}
    }
    
    // MARK: Use Case
    
    var categoriesUseCase: Factory<GetCategoriesUseCaseProtocol> {
        Factory(self) {GetCategoriesUseCase()}
    }
}
