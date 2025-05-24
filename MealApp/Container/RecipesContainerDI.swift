//
//  RecipesContainerDI.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import Foundation
import Factory

extension Container {
    // MARK: Remote Data Source
    var recipiesRemoteDS: Factory<RecipesRemoteDataSourceProtocol> {
        Factory(self) {
            RecipesRemoteDataSource()
        }
    }
    
    // MARK: - Repository
    
    var recipiesRepository: Factory<RecipesRepositoryProtocol> {
        Factory(self) {RecipesRepository()}
    }
    
    // MARK: Use Case
    
    var recipiesUseCase: Factory<RecipiesUseCaseProtocol> {
        Factory(self) {RecipiesUseCase()}
    }
}
