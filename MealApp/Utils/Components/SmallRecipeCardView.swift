//
//  SmallRecipeCardView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct SmallRecipeCardView: View {
    
    @State var isFavorited: Bool = false
    
    var recipe: Recipie
    var favBtnTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            WebImage(url: URL(string: recipe.thumbnailURL ?? "")) { image in
                image
                    .resizable()
                    .frame(height: 130)
                
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .frame(height: 130)
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    isFavorited.toggle()
                    favBtnTapped()
                } label: {
                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                        .foregroundStyle(.darkRed)
                        .padding(8)
                        .background(.white)
                        .clipShape(.circle)
                        .shadow(color: Color.text.opacity(0.25), radius: 2, x: 0, y: 2)
                }
                .padding(.top, 8)
            }
            
            Text(recipe.name ?? "")
                .font(.title1)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .padding(.leading, 8)
            
            Text(recipe.description ?? "")
                .font(.text3)
                .foregroundStyle(.text)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .padding(.leading, 8)
            
            HStack(spacing: 4) {
                Image(.icTimer)
                
                Text("\(recipe.totalTimeMinutes ?? 20)")
                
                Image(.icSeperator)
                
                Image(.icRating)
                
                Text("\(recipe.userRatings?.score?.starRating ?? 0, specifier: "%.2f")")
            }
            .font(.text3)
            .foregroundStyle(.text)
            .padding(.leading, 8)
            
            Text("£\(recipe.price?.total ?? 0)")
                .font(.title2)
                .foregroundStyle(.darkRed)
                .padding(.leading, 8)
        }
        .padding(.bottom, 8)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.text.opacity(0.25), radius: 4, x: 0, y: 4)
        .frame(width: 170, height: 274)
    }
}
