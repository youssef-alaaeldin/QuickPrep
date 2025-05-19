//
//  ReceptionSectionView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 07/05/2025.
//

import SwiftUI

struct RecipeSectionView: View {
    @EnvironmentObject private var coordinator: NavCoordinator
    @State var isFavorited: Bool = false
    let title: String
    let recipes: [Recipie]
    
    let onViewAllTapped: () -> Void
    var favBtnTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            TitleView(title: title, action: onViewAllTapped)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(recipes, id: \.id) { recipe in
                        SmallRecipeCardView(isFavorited: isFavorited, recipe: recipe) {
                            // TODO: Fav btn
                            favBtnTapped()
                        }
                        .onTapGesture {
                            coordinator.push(.recipeDetails(recipe: recipe))
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.horizontal, -16)
        }
        .padding(.horizontal, 16)
    }
}
