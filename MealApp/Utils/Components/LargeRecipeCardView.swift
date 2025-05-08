//
//  LargeRecipeCardVIew.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 08/05/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct LargeRecipeCardView: View {
    
    var recipe: Results
    
    var body: some View {
        HStack(spacing: 0) {
            WebImage(url: URL(string: recipe.thumbnailURL ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 143, height: 125)
                
            } placeholder: {
                
            }
            
            VStack(alignment: .leading, spacing: 7) {
                Text(recipe.name ?? "")
                    .font(.title)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                Text(recipe.description ?? "")
                    .font(.text4)
                    .foregroundStyle(.text)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 4) {
                    Image(.icTimer)
                    
                    Text("\(recipe.totalTimeMinutes ?? 20) mins")
                    
                    Image(.icSeperator)
                    
                    Image(.icRating)
                    
                    Text("\(recipe.userRatings?.score?.starRating ?? 0, specifier: "%.2f")")
                }
                .font(.text3)
                .foregroundStyle(.text)
                
                Text("£\(recipe.price?.total ?? 0)")
                    .font(.title2)
                    .foregroundStyle(.darkRed)
                
            }
            .padding(8)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.text.opacity(0.25), radius: 4, x: 0, y: 4)
    }
}

#Preview {
    LargeRecipeCardView(recipe: Results.mock)
        .padding(.horizontal, 16)
}
