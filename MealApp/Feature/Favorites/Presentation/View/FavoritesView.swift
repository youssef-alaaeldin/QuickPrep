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
            Text("Saved Dishes")
                .font(.heading2)
                .foregroundStyle(.blackishGrey)
                .padding(.top, 60)
                .padding(.horizontal, 16)
            
            if viewModel.favRecipes.isEmpty {
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
            } else {
                ScrollView {
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
                }
                .animation(.easeInOut, value: viewModel.favRecipes)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.getAllFav()
        }
    }
}

#Preview {
    FavoritesView()
}
