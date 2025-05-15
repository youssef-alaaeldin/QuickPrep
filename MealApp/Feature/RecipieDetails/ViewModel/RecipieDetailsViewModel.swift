//
//  RecipieDetailsViewModel.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 13/05/2025.
//

import Foundation

class RecipieDetailsViewModel: ObservableObject {
    @Published var selectedOption: RecipeOptions = .Ingredients
    @Published var formattedIngredients: [IngredientDisplay] = []
    @Published var instructions: [String] = []
    @Published var nutritionText: [String] = []

    init(recipe: Recipie) {
        loadIngredients(from: recipe)
        loadInstructions(from: recipe)
        loadNutrition(from: recipe)
    }

    private func loadIngredients(from recipe: Recipie) {
        let components = (recipe.sections ?? []).flatMap { $0.components ?? [] }
        formattedIngredients = components.map {
            let name = $0.ingredient?.name ?? "N/A"
            let measurement = $0.measurements?.first
            let quantity = (measurement?.quantity ?? "") + " " + (measurement?.unit?.abbreviation ?? "")
            return IngredientDisplay(name: name, quantity: quantity)
        }
    }

    private func loadInstructions(from recipe: Recipie) {
        instructions = recipe.instructions?.compactMap { $0.displayText } ?? []
    }

    private func loadNutrition(from recipe: Recipie) {
        guard let nutrition = recipe.nutrition else { return }
        nutritionText = [
            "Calories: \(nutrition.calories ?? 0)",
            "Carbohydrates: \(nutrition.carbohydrates ?? 0)g",
            "Fat: \(nutrition.fat ?? 0)g",
            "Fiber: \(nutrition.fiber ?? 0)g",
            "Protein: \(nutrition.protein ?? 0)g",
            "Sugar: \(nutrition.sugar ?? 0)g"
        ]
    }
}

