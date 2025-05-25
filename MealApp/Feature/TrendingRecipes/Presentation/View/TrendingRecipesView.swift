//
//  TrendingRecipesView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 18/05/2025.
//

import SwiftUI

struct TrendingRecipesView: View {
    @EnvironmentObject private var coordinator: NavCoordinator
    @EnvironmentObject private var favObserverViewModel: FavoritesObserverViewModel
    
    @StateObject private var viewModel: TrendingRecipesViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: .init())
    }
    var body: some View {
        VStack {
            topView
                .padding(.top, 50)
                .padding(.horizontal, 16)
                .background(.darkRed)
                .foregroundStyle(.white)
            
            ScrollView(.vertical, showsIndicators: false) {
                trendingRecipes
                    .padding(.top, 20)
                    .padding(.horizontal, 16)
                    .redactedLoading(isLoading: $viewModel.isTrendingRecipiesLoading)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden()
    }
    
    private var topView: some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 15, height: 25)
                .onTapGesture {
                    coordinator.pop()
                }
            
            Spacer()
            
            Text("Trending Recipes")
                .font(.heading2)
                .padding(.vertical, 20)
            
            Spacer()
        }
        
    }
    
    private var trendingRecipes: some View {
        LazyVStack(spacing: 24) {
            ForEach(viewModel.trendingRecipies ?? [], id: \.id) { recipe in
                LargeRecipeCardView(
                    isFavorited: favObserverViewModel.isFavorite(recipe: recipe),
                    recipe: recipe
                ) {
                    favObserverViewModel.toggleFavorite(recipe: recipe)
                }
                .onAppear {
                    if recipe == viewModel.trendingRecipies?.last {
                        viewModel.fetchTrendingRecipies(isPaginating: true)
                    }
                }
                .onTapGesture {
                    coordinator.push(.recipeDetails(recipe: recipe))
                }
            }
            
            if viewModel.isFetchingMoreRecipies {
                ProgressView()
                    .padding()
            }
        }
    }
}



#Preview {
    TrendingRecipesView()
}
