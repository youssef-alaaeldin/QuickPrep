//
//  CategoriesView.swift
//  MealApp
//
//  Created by Swift Copilot on 12/05/2025.
//

import SwiftUI

struct CategoriesView: View {
    var title: String
    var isSelected: Bool = false
    var namespace: Namespace.ID
    
    var body: some View {
        VStack(spacing: 1) {
            Text(title)
                .font(.title1)
                .foregroundStyle(isSelected ? .darkRed : .categories)
            
            ZStack {
                if isSelected {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.darkRed)
                        .matchedGeometryEffect(id: "underline", in: namespace)
                } else {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.clear)
                }
            }
        }
    }
}

//#Preview {
//    ScrollView(.horizontal) {
//        HStack {
//            CategoriesView(title: "Pizza", isSelected: true)
//            CategoriesView(title: "Pasta")
//        }
//    }
//}
