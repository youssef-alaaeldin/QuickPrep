//
//  MainView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 05/05/2025.
//

import SwiftUI

struct BottomTabsView: View {
//    init() {
//        setupTabBarAppearance()
//    }
    var body: some View {
        
        TabView {
            ForEach(TabItem.allCases, id: \.self) { tab in
                tab.view
                    .tabItem {
                        Label(tab.title, systemImage: tab.systemImage)
                    }
                    .ignoresSafeArea(edges: .top)
            }
        }
        .navigationBarBackButtonHidden()
        .tint(.darkRed)
        .toolbarBackground(.ultraThinMaterial, for: .tabBar)
    }
    
//    private func setupTabBarAppearance() {
//        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.systemBackground
//        
//        appearance.shadowColor = UIColor.black.withAlphaComponent(0.3)
//        appearance.shadowImage = UIImage()
//        UITabBar.appearance().standardAppearance = appearance
//        if #available(iOS 15.0, *) {
//            UITabBar.appearance().scrollEdgeAppearance = appearance
//        }
//    }
}

#Preview {
    BottomTabsView()
}
