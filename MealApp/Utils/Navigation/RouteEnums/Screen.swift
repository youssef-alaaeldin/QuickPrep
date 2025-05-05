//
//  Screen.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 05/05/2025.
//
import Foundation

enum Screen {
    case onboarding
}

extension Screen: Identifiable {
    var id: String {
        return String(describing: self).extractedStringBeforeParenthesis()
    }
}

extension Screen: Equatable {
    public static func == (lhs: Screen, rhs: Screen) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Screen: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
