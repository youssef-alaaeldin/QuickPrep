//
//  HomeView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @EnvironmentObject private var coordinator: NavCoordinator
    
    @Namespace private var categoryAnimation

    init() {
        self._viewModel = StateObject(wrappedValue: .init())
    }
    var body: some View {
        VStack {
            TopSearchView()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                trendingRecipies
                    .padding(.top, 24)
                    .redactedLoading(isLoading: $viewModel.isTrendingRecipiesLoading)
                
                comfortFoodClassics
                    .padding(.top, 24)
                    .redactedLoading(isLoading: $viewModel.isClassicRecipiesLoading)
                
                
                allRecipiesList
                    .padding(.top, 24)
                    .padding(.bottom, 44)
                    .redactedLoading(isLoading: $viewModel.isCategoriesRecipiesLoading)
                
                
            }
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
    
    private var categoriesBar: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Endless Culinary Journey")
                .font(.heading3)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 24) {
                    ForEach(viewModel.categories ?? [], id: \.id) { category in
                        
                        CategoriesView(
                            title: category.displayName ?? "",
                            isSelected: category == viewModel.selectedCategory,
                            namespace: categoryAnimation
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                viewModel.selectedCategory = category
                                viewModel.categoryRecipiesLoadingState = .loading
                                viewModel.categoryRecipiesOffset = 0
                                viewModel.fetchBasedOnCategory()
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
    }
    
    private var allRecipiesList: some View {
        LazyVStack(spacing: 24, pinnedViews: [.sectionHeaders]) {
            Section {
                ForEach(viewModel.categoryRecipies ?? [], id: \.id) { recipe in
                    LargeRecipeCardView(recipe: recipe) {
                        // TODO: Fav button
                    }
                    .onAppear {
                        if recipe == viewModel.categoryRecipies?.last {
                            viewModel.fetchBasedOnCategory(isPaginating: true)
                        }
                    }
                    .onTapGesture {
                        coordinator.push(.recipeDetails(recipe: recipe))
                    }
                }
                
                if viewModel.isFetchingMoreCategoryRecipies {
                    ProgressView()
                        .padding()
                }
            } header: {
                categoriesBar
                    .redactedLoading(isLoading: $viewModel.isCategoriesLoading)
                    .unredacted()
                    .background(Color(.systemBackground))
                    .padding(.horizontal, -16)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    HomeView()
}
