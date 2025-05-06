//
//  SmallRecipeCardView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import SwiftUI

struct SmallRecipeCardView: View {
    
    var recipe: Results
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(.onboarding)
                .resizable()
                .frame(width: 200, height: 130)
            
            Text(recipe.name ?? "")
                .font(.title)
            
            Text(recipe.description ?? "")
                .font(.text3)
                .foregroundStyle(.text)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                
            HStack(spacing: 4) {
                Image(.icTimer)
                
                Text("\(recipe.totalTimeMinutes ?? 0)")
                
                Image(.icSeperator)
                
                Image(.icRating)
                
                Text("\(recipe.userRatings?.score ?? 0)")
            }
            .font(.text3)
            .foregroundStyle(.text)
        }
        .padding(.leading, 8)
        .padding(.bottom, 8)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.text.opacity(0.1), radius: 4, x: 0, y: 4)
        .frame(width: 200)
    }
}
