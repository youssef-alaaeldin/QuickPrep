//
//  FavoritesRepository.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 19/05/2025.
//

import Foundation
import CoreData

final class FavoritesRepository: FavoritesRepositoryProtocol {
    private let context = CoreDataStack.shared.context

    func save(_ recipe: Recipie) {
        guard !isFavorite(recipe) else { return }

        let entity = FavoriteRecipeEntity(context: context)
        entity.id = Int64(recipe.id ?? 0)
        entity.name = recipe.name ?? ""
        entity.thumbnail = recipe.thumbnailURL ?? ""

        try? context.save()
    }

    func remove(_ recipe: Recipie) {
        let request = FavoriteRecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", recipe.id ?? 0)

        if let results = try? context.fetch(request),
           let toDelete = results.first {
            context.delete(toDelete)
            try? context.save()
        }
    }

    func isFavorite(_ recipe: Recipie) -> Bool {
        let request = FavoriteRecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", recipe.id ?? 0)

        let count = (try? context.count(for: request)) ?? 0
        return count > 0
    }

    func fetchAll() -> [Recipie] {
        let request = FavoriteRecipeEntity.fetchRequest()
        guard let results = try? context.fetch(request) else { return [] }

        return results.map {
            Recipie(
                approvedAt: nil,
                aspectRatio: nil,
                buzzID: nil,
                canonicalID: nil,
                compilations: nil,
                cookTimeMinutes: nil,
                country: nil,
                createdAt: nil,
                credits: nil,
                description: $0.desc,
                draftStatus: nil,
                facebookPosts: nil,
                id: Int($0.id),
                inspiredByURL: nil,
                instructions: nil,
                isAppOnly: nil,
                isOneTop: nil,
                isShoppable: nil,
                isSubscriberContent: nil,
                keywords: nil,
                language: nil,
                name: $0.name,
                numServings: nil,
                nutrition: nil,
                nutritionVisibility: nil,
                originalVideoURL: nil,
                prepTimeMinutes: nil,
                price: nil,
                promotion: nil,
                renditions: nil,
                sections: nil,
                seoPath: nil,
                seoTitle: nil,
                servingsNounPlural: nil,
                servingsNounSingular: nil,
                show: nil,
                showID: nil,
                slug: nil,
                tags: nil,
                thumbnailAltText: nil,
                thumbnailURL: $0.thumbnail,
                tipsAndRatingsEnabled: nil,
                topics: nil,
                totalTimeMinutes: nil,
                totalTimeTier: nil,
                updatedAt: nil,
                userRatings: nil,
                videoAdContent: nil,
                videoID: nil,
                videoURL: nil,
                yields: nil,
                tipsSummary: nil
            )
        }
    }
}
