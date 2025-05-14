//
//  RecipieDetailsViewModel.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 13/05/2025.
//

import Foundation

class RecipieDetailsViewModel: ObservableObject {
    @Published var formattedIngredients: [IngredientDisplay] = []
    
    init(recipe: Recipie) {
        self.loadIngredients(from: recipe)
    }
    
    private func loadIngredients(from recipe: Recipie) {
        let components = recipe.sections?.flatMap { $0.components ?? [] } ?? []
        self.formattedIngredients = components.map { component in
            let name = component.ingredient?.name ?? "Unknown Ingredient"
            let measurements: [String] = component.measurements?.compactMap { measurement in
                if let quantity = measurement.quantity,
                   let unit = measurement.unit?.name {
                    return "\(quantity) \(unit)"
                } else if let quantity = measurement.quantity {
                    return "\(quantity)"
                } else {
                    return nil
                }
            } ?? []
            
            let displayMeasurement = measurements.isEmpty ? "Unknown Quantity" : measurements.joined(separator: ", ")
            
            return IngredientDisplay(id: component.id ?? 0, name: name, quantity: displayMeasurement)
        }
    }
}

struct IngredientDisplay: Identifiable {
    let id: Int
    let name: String
    let quantity: String
}
