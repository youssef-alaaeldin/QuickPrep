//
//  CustomButton.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 05/05/2025.
//

import SwiftUI

struct CustomButton: View {
    // MARK: - Configurable Properties
    var title: String
    var action: () -> Void
    
    var backgroundColor: Color = .darkRed
    var foregroundColor: Color = .white
    var cornerRadius: CGFloat = 50
    var font: Font = .heading3
    
    var strokeColor: Color? = nil
    var strokeWidth: CGFloat = 1
    
    var horizontalPadding: CGFloat = 16
    var verticalPadding: CGFloat = 15
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, verticalPadding)
                .padding(.horizontal, horizontalPadding)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(backgroundColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(strokeColor ?? .clear, lineWidth: strokeColor != nil ? strokeWidth : 0)
                        )
                )
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    VStack(spacing: 16) {
        CustomButton(title: "Get Started") {
            print("Primary Button Tapped")
        }
        
        CustomButton(
            title: "Outlined Button",
            action: { print("Outlined tapped") },
            backgroundColor: .clear,
            foregroundColor: .red,
            cornerRadius: 25,
            font: .title3,
            strokeColor: .red,
            strokeWidth: 2
        )
        
        CustomButton(
            title: "Custom BG + Font",
            action: { print("Fancy tapped") },
            backgroundColor: Color.green,
            foregroundColor: .black,
            cornerRadius: 50,
            font: .system(size: 18, weight: .bold)
        )
    }
    .padding()
}
