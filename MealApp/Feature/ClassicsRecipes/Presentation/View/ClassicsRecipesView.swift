//
//  ClassicsRecipesView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 18/05/2025.
//

import SwiftUI

struct ClassicsRecipesView: View {
    @EnvironmentObject private var coordinator: NavCoordinator
    @EnvironmentObject private var favObserverViewModel: FavoritesObserverViewModel
    
    @StateObject private var viewModel: ClassicsRecipesViewModel
    
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
                classicsRecipes
                    .padding(.top, 20)
                    .padding(.horizontal, 16)
                    .redactedLoading(isLoading: $viewModel.isClassicsRecipiesLoading)
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
            
            Text("Classics Recipes")
                .font(.heading2)
                .padding(.vertical, 20)
            
            Spacer()
        }
        
    }
    
    private var classicsRecipes: some View {
        LazyVStack(spacing: 24) {
            ForEach(viewModel.classicsRecipies ?? [], id: \.id) { recipe in
                LargeRecipeCardView(
                    isFavorited: favObserverViewModel.isFavorite(recipe: recipe),
                    recipe: recipe
                ) {
                    favObserverViewModel.toggleFavorite(recipe: recipe)
                }
                .onAppear {
                    if recipe == viewModel.classicsRecipies?.last {
                        viewModel.fetchClassicsRecipies(isPaginating: true)
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
    ClassicsRecipesView()
}

