//
//  TitleView.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 07/05/2025.
//

import SwiftUI

struct TitleView: View {
    @State var title: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(.heading3)
            
            Spacer()
            
            Button {
                action()
            } label: {
                Text("View All")
                    .font(.text3)
                    .foregroundStyle(.darkRed)
            }
        }
    }
}

//#Preview {
//    TitleView()
//}
