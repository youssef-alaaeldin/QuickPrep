//
//  View+Extension.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 24/05/2025.
//

import Foundation
import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

extension View {
    func onScrollOffsetChange(_ onChange: @escaping (CGFloat) -> Void) -> some View {
        self.background(
            GeometryReader { geo in
                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
            }
        )
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: onChange)
    }
}
