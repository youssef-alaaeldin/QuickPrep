//
//  RedactedLoading.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 07/05/2025.
//

import Foundation
import SwiftUI

struct RedactedLoadingModifier: ViewModifier {
    @Binding var isLoading: Bool
    @State private var opacity: Double = 1.0
    @State private var animationActive = false

    func body(content: Content) -> some View {
        content
            .redacted(reason: isLoading ? .placeholder : [])
            .disabled(isLoading)
            .opacity(opacity)
            .onChange(of: isLoading) { newValue in
                if newValue {
                    startOpacityAnimation()
                } else {
                    opacity = 1.0
                }
            }
            .onAppear {
                if isLoading {
                    startOpacityAnimation()
                }
            }
            .onDisappear {
                stopOpacityAnimation()
            }
    }

    private func startOpacityAnimation() {
        animationActive = true
        withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
            opacity = 0.3
        }
    }

    private func stopOpacityAnimation() {
        animationActive = false
        opacity = 1.0
    }
}


public extension View {
    func redactedLoading(isLoading: Binding<Bool>) -> some View {
        self.modifier(RedactedLoadingModifier(isLoading: isLoading))
    }
}
