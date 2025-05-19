//
//  SearchView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 18/05/2025.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var coordinator: NavCoordinator
    
    @StateObject private var viewModel: SearchViewModel
    
    @FocusState private var isSearchFieldFocused: Bool
    
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
            Spacer()
            if viewModel.searchText.isEmpty {
                Text("Start typing to search for recipes...")
                    .font(.text1)
                    .foregroundStyle(.blackishGrey)
            }
            else {
                ScrollView(.vertical, showsIndicators: false) {
                    searchRecipes
                        .padding(.top, 20)
                        .padding(.horizontal, 16)
                        .redactedLoading(isLoading: $viewModel.isSearchRecipesLoading)
                }
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden()
        .onAppear {
            isSearchFieldFocused = true
        }
    }
    
    private var topView: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 15, height: 25)
                    .onTapGesture {
                        coordinator.pop()
                    }
                
                Spacer()
                
                Text("Search Dishes")
                    .font(.heading2)
                    .padding(.vertical, 20)
                
                Spacer()
            }
            
            SearchTextField(searchText: $viewModel.searchText)
                .focused($isSearchFieldFocused)
                .padding(.bottom, 16)
        }
        
    }
    
    private var searchRecipes: some View {
        LazyVStack(spacing: 24) {
            ForEach(viewModel.searchRecipes ?? [], id: \.id) { recipe in
                LargeRecipeCardView(recipe: recipe) {
                    // TODO: Fav Btn
                }
                .onAppear {
                    if recipe == viewModel.searchRecipes?.last {
                        viewModel.fetchRecipesBasedOnSearch(isPaginating: true)
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
    SearchView()
}
