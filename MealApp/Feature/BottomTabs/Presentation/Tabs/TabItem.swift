//
//  TabItem.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import Foundation
import SwiftUI

enum TabItem: CaseIterable, Hashable {
    case home
    case search
    case favorites

    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .favorites: return "Favorites"
        }
    }

    var systemImage: String {
        switch self {
        case .home: return "house"
        case .search: return "magnifyingglass"
        case .favorites: return "heart"
        }
    }

    @ViewBuilder
    var view: some View {
        switch self {
        case .home:
            HomeView()
        case .search:
            SearchView()
        case .favorites:
            FavoritesView()
        }
    }
}
