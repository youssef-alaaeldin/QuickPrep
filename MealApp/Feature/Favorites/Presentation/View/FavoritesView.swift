//
//  FavoritesView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 19/05/2025.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var coordinator: NavCoordinator
    @StateObject private var viewModel: FavoritesObserverViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: .init())
    }
    var body: some View {
        VStack {
            topBar
            
            if viewModel.favRecipes.isEmpty {
                emptyFav
            } else {
                ScrollView {
                    favRecipes
                }
                .animation(.easeInOut, value: viewModel.favRecipes)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.getAllFav()
        }
        
    }
    
    private var topBar: some View {
        Text("Saved Dishes")
            .font(.heading2)
            .foregroundStyle(.blackishGrey)
            .padding(.top, 60)
            .padding(.horizontal, 16)
    }
    
    private var emptyFav: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.slash")
                .font(.system(size: 40))
                .foregroundStyle(.customGrey)
            Text("No favorites yet.")
                .font(.text2)
                .foregroundStyle(.customGrey)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(.easeInOut, value: viewModel.favRecipes)
    }
    
    private var favRecipes: some View {
        LazyVStack(spacing: 24) {
            ForEach(viewModel.favRecipes, id: \.id) { recipe in
                LargeRecipeCardView(recipe: recipe) {
                    viewModel.toggleFavorite(recipe: recipe)
                    viewModel.getAllFav()
                }
                .onTapGesture {
                    coordinator.push(.recipeDetails(recipe: recipe))
                }
            }
        }
        .padding(.top, 20)
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
}

#Preview {
    FavoritesView()
}
