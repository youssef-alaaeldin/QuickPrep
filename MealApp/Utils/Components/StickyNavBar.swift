//
//  StickyNavBar.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 24/05/2025.
//

import SwiftUI

struct StickyNavBar: View {
    let isFav: Bool
    let showBackground: Bool
    let backAction: () -> Void
    let favAction: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: backAction) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                        )
                        .shadow(color: .blackishGrey.opacity(0.25), radius: 4, x: 0, y: 2)
                }
                
                Spacer()
                
                Button(action: favAction) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: isFav ? "heart.fill" : "heart")
                                .foregroundColor(.darkRed)
                        )
                        .shadow(color: .blackishGrey.opacity(0.25), radius: 4, x: 0, y: 2)
                }
            }
            .padding(.horizontal)
            .padding(.top, 60)
            .padding(.bottom, 12)
            .background(
                showBackground ? .white : .clear
            )
            .shadow(color: .blackishGrey.opacity(0.25), radius: 4)
            .animation(.easeInOut, value: showBackground)
            
            Spacer()
        }
    }
}
