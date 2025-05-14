//
//  RecipieDetailsView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 13/05/2025.
//

import SwiftUI
import SDWebImageSwiftUI

enum RecipeOptions: String, CaseIterable {
    case Ingredients
    case Instructions
    case Nutrition
}

struct RecipieDetailsView: View {
    @EnvironmentObject private var coordinator: NavCoordinator
    @StateObject private var viewModel: RecipieDetailsViewModel
    
    var recipie: Recipie
    
    init(recipie: Recipie) {
        self.recipie = recipie
        self._viewModel = StateObject(wrappedValue: .init(recipe: recipie))
    }
    
    private var flattenedComponents: [MealComponent] {
        (recipie.sections ?? []).flatMap { $0.components ?? [] }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                RecipieHeaderView(imageURL: recipie.thumbnailURL ?? "") {
                    // Favorite button action
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
                .ignoresSafeArea(edges: .top)
                .offset(y: -32)
                
                recipeIngredientView
                    .padding(.horizontal, 16)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden()
    }
    
    private var recipeIngredientView: some View {
        LazyVStack(alignment: .leading, spacing: 16, pinnedViews: .sectionHeaders) {
            Section {
                ForEach(viewModel.formattedIngredients) { ingredient in
                    HStack {
                        Text(ingredient.name)
                            .foregroundStyle(.blackishGrey)
                        Spacer()
                        Text(ingredient.quantity)
                            .foregroundStyle(.text)
                    }
                    .font(.text2)
                    .padding(.vertical, 4)
                }
            } header: {
                RecipeOptionsBarView()
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
            
            Text("£\(price)")
                .font(.heading3)
                .foregroundColor(.darkRed)
            
            Text(desc)
                .font(.text2)
                .foregroundColor(.text)
            
            HStack(spacing: 24) {
                InfoPillView(icon: "clock.fill", title: time)
                Rectangle().frame(width: 2).foregroundStyle(.divider)
                InfoPillView(icon: "flame.fill", title: calories)
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
                
                Button(action: favBtnAction) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: "heart")
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
    @State var selectedRecipeOption: RecipeOptions = .Ingredients
    @Namespace private var recipeOptionsAnimation
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 24) {
                ForEach(RecipeOptions.allCases, id: \.rawValue) { recipe in
                    CategoriesView(
                        title: recipe.rawValue,
                        isSelected: recipe == selectedRecipeOption,
                        namespace: recipeOptionsAnimation
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedRecipeOption = recipe
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
