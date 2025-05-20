//
//  FavoritesObserverViewModel.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 19/05/2025.
//

import Foundation
import Combine
import Factory

final class FavoritesObserverViewModel: ObservableObject {
    @Injected(\.favoritesUseCase) private var favoritesUseCase
    
    @Published private(set) var favoriteIDs: Set<Int> = []
    @Published var favRecipes: [Recipie] = []
    
    func isFavorite(recipe: Recipie) -> Bool {
        guard let id = recipe.id else { return false }
        return favoriteIDs.contains(id)
    }

    func toggleFavorite(recipe: Recipie) {
        favoritesUseCase.toggleFavorite(recipe: recipe)
        
        if let id = recipe.id {
            if favoriteIDs.contains(id) {
                favoriteIDs.remove(id)
            } else {
                favoriteIDs.insert(id)
            }
        }

        favRecipes = favoritesUseCase.getFavorites()
    }

    func refresh() {
        favoriteIDs = Set(favoritesUseCase.getFavorites().compactMap { $0.id })
    }
    
    func getAllFav() {
        self.favRecipes = favoritesUseCase.getFavorites()
    }
    
}
