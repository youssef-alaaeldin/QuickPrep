//
//  ReceptionSectionView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 07/05/2025.
//

import SwiftUI

struct RecipeSectionView: View {
    let title: String
    let recipes: [Recipie]
    let onViewAllTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            TitleView(title: title, action: onViewAllTapped)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(recipes, id: \.id) { recipe in
                        SmallRecipeCardView(recipe: recipe) {
                            // TODO: Fav btn
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
