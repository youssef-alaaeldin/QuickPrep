//
//  FavoritesRepository.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 19/05/2025.
//

import Foundation

protocol FavoritesRepositoryProtocol {
    func save(_ recipe: Recipie)
    func remove(_ recipe: Recipie)
    func isFavorite(_ recipe: Recipie) -> Bool
    func fetchAll() -> [Recipie]
}
