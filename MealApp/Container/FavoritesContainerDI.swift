//
//  FavoritesContainerDI.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 19/05/2025.
//

import Foundation
import Factory

extension Container {
    var favoritesRepositroy: Factory<FavoritesRepositoryProtocol> {
        Factory(self) { FavoritesRepository() }
    }
    
    var favoritesUseCase: Factory<FavoritesUseCaseProtocol> {
        Factory(self) { FavoritesUseCase() }
    }
}
