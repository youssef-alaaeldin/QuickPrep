//
//  FullScreen.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 05/05/2025.
//

import Foundation

enum FullScreenCover {
    case Test
}

extension FullScreenCover: Identifiable {
    var id: String {
        return String(describing: self).extractedStringBeforeParenthesis()
    }
}

extension FullScreenCover: Equatable {
    public static func == (lhs: FullScreenCover, rhs: FullScreenCover) -> Bool {
        return lhs.id == rhs.id
    }
}

extension FullScreenCover: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
