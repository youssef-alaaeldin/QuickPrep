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
    @State private var showLaunchScreen: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavCoordinatorView(coordinator: coordinator, favObserverViewModel: favObserverViewModel, rootView: .onboarding)
                
                ZStack {
                    if showLaunchScreen {
                        SplashScreenView(showLaunchScreen: $showLaunchScreen)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
