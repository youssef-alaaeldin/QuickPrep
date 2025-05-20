//
//  MealAppApp.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 01/05/2025.
//

import SwiftUI

@main
struct MealAppApp: App {
    @StateObject var coordinator = NavCoordinator()
    @StateObject var favObserverViewModel = FavoritesObserverViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavCoordinatorView(coordinator: coordinator, favObserverViewModel: favObserverViewModel, rootView: .onboarding)
        }
    }
}
