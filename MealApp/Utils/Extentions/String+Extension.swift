//
//  String+Extension.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 05/05/2025.
//

import Foundation
extension String {
    func extractedStringBeforeParenthesis() -> String {
        if let index = self.firstIndex(of: "(") {
            return String(self.prefix(upTo: index))
        } else {
            return self
        }
    }
    
    func formattedDate() -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = isoFormatter.date(from: self) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            return dateFormatter.string(from: date)
        }
        return "Invalid Date"
    }
}
