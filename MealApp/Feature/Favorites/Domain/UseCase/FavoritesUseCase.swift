//
//  FavoritesUseCase.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 19/05/2025.
//
import Foundation
import Factory

protocol FavoritesUseCaseProtocol {
    func toggleFavorite(recipe: Recipie)
    func isFavorite(recipe: Recipie) -> Bool
    func getFavorites() -> [Recipie]
}

final class FavoritesUseCase: FavoritesUseCaseProtocol {
    @Injected(\.favoritesRepositroy) var favoritesRepositroy

    func toggleFavorite(recipe: Recipie) {
        if favoritesRepositroy.isFavorite(recipe) {
            favoritesRepositroy.remove(recipe)
        } else {
            favoritesRepositroy.save(recipe)
        }
    }

    func isFavorite(recipe: Recipie) -> Bool {
        return favoritesRepositroy.isFavorite(recipe)
    }

    func getFavorites() -> [Recipie] {
        return favoritesRepositroy.fetchAll()
    }
}
