//
//  RecipieDetailsView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 13/05/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipieDetailsView: View {
    @EnvironmentObject private var coordinator: NavCoordinator
    @EnvironmentObject private var favObserver: FavoritesObserverViewModel

    @StateObject private var viewModel: RecipieDetailsViewModel
    
    var recipie: Recipie
    
    init(recipie: Recipie) {
        self.recipie = recipie
        self._viewModel = StateObject(wrappedValue: .init(recipe: recipie))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                RecipieHeaderView(
                    isFav: favObserver.isFavorite(recipe: recipie),
                    imageURL: recipie.thumbnailURL ?? ""
                ) {
                    favObserver.toggleFavorite(recipe: recipie)
                } backBtnAction: {
                    coordinator.pop()
                }
                
                RecipieInfoView(
                    title: recipie.name ?? "",
                    price: recipie.price?.total ?? 0,
                    desc: recipie.description ?? "",
                    time: String(recipie.totalTimeMinutes ?? 0),
                    calories: String(recipie.nutrition?.calories ?? 0),
                    rating: String(format: "%.2f", recipie.userRatings?.score?.starRating ?? 0)
                )
                .padding(20)
                .background(
                    RoundedCorner(radius: 20, corners: [.topLeft, .topRight])
                        .fill(Color(.systemBackground))
                )
                .offset(y: -32)
                
                recipeOptionsView
                    .padding(.horizontal, 16)
            }
        }
        .navigationBarBackButtonHidden()
        .edgesIgnoringSafeArea(.top)
    }
    
    private var recipeOptionsView: some View {
        LazyVStack(alignment: .leading, spacing: 16, pinnedViews: .sectionHeaders) {
            Section {
                Group {
                    switch viewModel.selectedOption {
                        case .Ingredients:
                            ingredientsList
                        case .Instructions:
                            instructionsList
                        case .Nutrition:
                            nutritionList
                                .padding(.bottom, 16)
                    }
                }
                .transition(.asymmetric(insertion:.fade, removal: .fade))
            } header: {
                RecipeOptionsBarView(selectedOption: $viewModel.selectedOption)
                    .background(Color(.systemBackground))
            }
        }
    }
    
    private var ingredientsList: some View {
        LazyVStack(alignment: .leading, spacing: 12) {
            ForEach(viewModel.formattedIngredients) { ingredient in
                HStack {
                    Text(ingredient.name.capitalized)
                        .foregroundStyle(.blackishGrey)
                    Spacer()
                    Text(ingredient.quantity)
                        .foregroundStyle(.text)
                }
                .font(.text2)
                .padding(.vertical, 4)
            }
        }
    }
    
    private var instructionsList: some View {
        LazyVStack(alignment: .leading, spacing: 12) {
            ForEach(viewModel.instructions.indices, id: \.self) { index in
                Text("\(index + 1). \(viewModel.instructions[index])")
                    .font(.text2)
                    .foregroundStyle(.blackishGrey)
            }
        }
    }
    
    private var nutritionList: some View {
        LazyVStack(alignment: .leading, spacing: 12) {
            ForEach(viewModel.nutritionText, id: \.self) { item in
                Text(item)
                    .font(.text2)
                    .foregroundStyle(.blackishGrey)
            }
        }
    }
}

// MARK: - Recipie Info

struct RecipieInfoView: View {
    var title: String
    var price: Int
    var desc: String
    var time: String
    var calories: String
    var rating: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.heading2)
            
            Text("\u{00A3}\(price)")
                .font(.heading3)
                .foregroundColor(.darkRed)
            
            Text(desc)
                .font(.text2)
                .foregroundColor(.text)
            
            HStack(spacing: 28) {
                InfoPillView(icon: "clock.fill", title: "\(time) mins")
                Rectangle().frame(width: 2).foregroundStyle(.divider)
                InfoPillView(icon: "flame.fill", title: "\(calories) cal")
                Rectangle().frame(width: 2).foregroundStyle(.divider)
                InfoPillView(icon: "star.fill", title: rating)
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 12)
            .background(.infoBg)
            .cornerRadius(60)
            .frame(maxWidth: .infinity)
            .padding(.top, 16)
        }
    }
}

// MARK: - Header View

struct RecipieHeaderView: View {
    @State var isFav: Bool = false
    var imageURL: String
    var favBtnAction: () -> Void
    var backBtnAction: () -> Void
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.red.ignoresSafeArea()
            
            WebImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 8)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 8)
            }
            
            HStack {
                Button(action: backBtnAction) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                        )
                }
                
                Spacer()
                
                Button {
                    isFav.toggle()
                    favBtnAction()
                } label: {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: isFav ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                            )
                }
            }
            .padding(.horizontal)
            .padding(.top, 60)
        }
    }
}

// MARK: - InfoPillView

struct InfoPillView: View {
    var icon: String
    var title: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(.darkRed)
            
            Text(title)
                .font(.title2)
                .foregroundStyle(.blackishGrey)
        }
    }
}

// MARK: - Recipe Options Bar

struct RecipeOptionsBarView: View {
    @Binding var selectedOption: RecipeOptions
    @Namespace private var recipeOptionsAnimation
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 24) {
                ForEach(RecipeOptions.allCases, id:\.rawValue) { recipe in
                    CategoriesView(
                        title: recipe.rawValue,
                        isSelected: recipe == selectedOption,
                        namespace: recipeOptionsAnimation
                    )
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedOption = recipe
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RecipieDetailsView(recipie: Recipie.mock)
}
