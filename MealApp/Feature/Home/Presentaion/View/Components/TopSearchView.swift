//
//  TopSearchView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import SwiftUI

struct TopSearchView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Hello, Youssef!")
                .font(.heading1)
                .padding(.bottom, 8)
                .padding(.top, 60)
            
            Text("What would you like to make?")
                .font(.text1)
                .padding(.bottom, 24)
            
            SearchTextField()
                .padding(.bottom, 16)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 16)
        .background(.darkRed)
        .clipShape(RoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight]))
        .shadow(color: .customGrey.opacity(0.2), radius: 5, x: 0, y: 6)
        .ignoresSafeArea(edges: .top)
    }
}


#Preview {
    TopSearchView()
}
