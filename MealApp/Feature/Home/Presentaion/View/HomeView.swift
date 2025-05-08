//
//  HomeView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: .init())
    }
    var body: some View {
        VStack {
            TopSearchView()
            
            ScrollView(.vertical, showsIndicators: false) {
                trendingRecipies
                    .padding(.top, 24)
                
                comfortFoodClassics
                    .padding(.top, 24)
                
                allRecipiesList
                    .padding(.top, 24)
                    .padding(.bottom, 44)
                
            }
            .redactedLoading(isLoading: $viewModel.isLoading)
        }
    }
    
    private var trendingRecipies: some View {
        RecipeSectionView(
            title: "Trending Recipes",
            recipes: viewModel.trendingRecipies ?? []
        ) {
            
        }
    }
    
    private var comfortFoodClassics: some View {
        RecipeSectionView(
            title: "Comfort Food Classics",
            recipes: viewModel.classicsRecipies ?? []
        ) {
            
        }
    }
    
    private var allRecipiesList: some View {
        LazyVStack(spacing: 24) {
            ForEach(viewModel.trendingRecipies ?? [], id: \.id) { recipe in
                LargeRecipeCardView(recipe: recipe) {
                    // TODO: Fav button
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    HomeView()
}
