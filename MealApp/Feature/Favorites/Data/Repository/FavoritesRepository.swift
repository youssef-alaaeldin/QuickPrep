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
        guard !isFavorite(recipe) else {
            print("🟡 Recipe \(recipe.id ?? -1) is already favorited.")
            return
        }

        let entity = FavoriteRecipeEntity(context: context)
        entity.id = Int64(recipe.id ?? 0)
        entity.name = recipe.name ?? ""
        entity.thumbnail = recipe.thumbnailURL ?? ""
        entity.desc = recipe.description ?? ""
        entity.calories = Int64(recipe.nutrition?.calories ?? 0)
        entity.price = Int64(recipe.price?.total ?? 0)
        entity.rating = recipe.userRatings?.score ?? 0.0
        entity.timeTaken = Int64(recipe.totalTimeMinutes ?? 30)
        if let nutrition = try? JSONEncoder().encode(recipe.nutrition) {
            entity.nutrition = nutrition
        }
        
        if let instructions = try? JSONEncoder().encode(recipe.instructions) {
            entity.instructions = instructions
        }
        
        if let section = try? JSONEncoder().encode(recipe.sections) {
            entity.sections = section
        }
        
        do {
            try context.save()
            print("✅ Saved recipe to favorites: \(recipe.name ?? "")")
        } catch {
            print("❌ Failed to save favorite: \(error)")
        }
    }

    func remove(_ recipe: Recipie) {
        let request = FavoriteRecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", recipe.id ?? 0)

        do {
            let results = try context.fetch(request)
            if let toDelete = results.first {
                context.delete(toDelete)
                try context.save()
                print("🗑️ Removed recipe from favorites: \(recipe.name ?? "")")
            } else {
                print("ℹ️ No matching recipe found to delete for ID \(recipe.id ?? -1)")
            }
        } catch {
            print("❌ Failed to remove favorite: \(error)")
        }
    }

    func isFavorite(_ recipe: Recipie) -> Bool {
        let request = FavoriteRecipeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", recipe.id ?? 0)

        do {
            let count = try context.count(for: request)
            print("🔍 Checked if recipe is favorite (\(recipe.name ?? "")): \(count > 0)")
            return count > 0
        } catch {
            print("❌ Failed to check if recipe is favorite: \(error)")
            return false
        }
    }

    func fetchAll() -> [Recipie] {
        let request = FavoriteRecipeEntity.fetchRequest()

        do {
            let results = try context.fetch(request)
            print("📦 Fetched \(results.count) favorite recipes.")
            
            return results.map {
                let nutrition = try? JSONDecoder().decode(Nutrition.self, from: $0.nutrition ?? Data())
                
                let instructions = try? JSONDecoder().decode([Instruction].self, from: $0.instructions ?? Data())
                
                let sections = try? JSONDecoder().decode([MealSection].self, from: $0.sections ?? Data())
                
                return Recipie(
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
                    instructions: instructions,
                    isAppOnly: nil,
                    isOneTop: nil,
                    isShoppable: nil,
                    isSubscriberContent: nil,
                    keywords: nil,
                    language: nil,
                    name: $0.name,
                    numServings: nil,
                    nutrition: nutrition,
                    nutritionVisibility: nil,
                    originalVideoURL: nil,
                    prepTimeMinutes: nil,
                    price: Price(
                        consumptionPortion: nil,
                        consumptionTotal: nil,
                        portion: nil,
                        total: Int($0.price),
                        updatedAt: nil
                    ),
                    promotion: nil,
                    renditions: nil,
                    sections: sections,
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
                    totalTimeMinutes: Int($0.timeTaken),
                    totalTimeTier: nil,
                    updatedAt: nil,
                    userRatings: UserRatings(
                        countNegative: nil,
                        countPositive: nil,
                        score: $0.rating
                    ),
                    videoAdContent: nil,
                    videoID: nil,
                    videoURL: nil,
                    yields: nil,
                    tipsSummary: nil
                )
            }
        } catch {
            print("❌ Failed to fetch favorites: \(error)")
            return []
        }
    }
}
