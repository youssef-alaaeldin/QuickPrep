//
//  Sheet.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 05/05/2025.
//

import SwiftUI

enum Sheet {
    case videoPlayer(videURL: String)
}

extension Sheet: Identifiable {
    var id: String {
        return String(describing: self).extractedStringBeforeParenthesis()
    }
}

extension Sheet: Equatable {
    public static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Sheet: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
