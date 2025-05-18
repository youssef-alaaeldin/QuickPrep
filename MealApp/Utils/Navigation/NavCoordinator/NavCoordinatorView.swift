//
//  NavCoordinatorView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 05/05/2025.
//

import SwiftUI

struct NavCoordinatorView: View {
    @StateObject var coordinator: NavCoordinator
    var rootView: Screen
    
    public init(coordinator: NavCoordinator, rootView: Screen) {
        self._coordinator = StateObject(wrappedValue: coordinator)
        self.rootView = rootView
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(screen: rootView)
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.build(screen: screen)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(sheet: sheet)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
                    coordinator.build(fullScreenCover: fullScreenCover)
                }
        }
        .environmentObject(coordinator)
        .navigationBarBackButtonHidden()
    }
}

