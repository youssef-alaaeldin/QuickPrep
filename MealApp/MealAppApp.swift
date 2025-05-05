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
    
    var body: some Scene {
        WindowGroup {
            NavCoordinatorView(coordinator: coordinator, rootView: .onboarding)
        }
    }
}
