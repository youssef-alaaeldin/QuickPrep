//
//  NavigationHandler+Screen.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 05/05/2025.
//
//

//MARK: - Screen builder

import SwiftUI
extension NavCoordinator {
    @ViewBuilder
    public func build(screen: Screen) -> some View {
        switch screen {
        case .onboarding:
            Text("Onboarding")
        }
    }
}

