//
//  SearchTextField.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 06/05/2025.
//

import SwiftUI

struct SearchTextField: View {
    @State private var searchText: String = ""
    
    var body: some View {
        HStack(spacing: 17) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search dishes", text: $searchText)
                .foregroundColor(.customGrey)
        }
        .padding(.vertical, 17)
        .padding(.leading, 18)
        .background(.white)
        .cornerRadius(50)
    }
}
