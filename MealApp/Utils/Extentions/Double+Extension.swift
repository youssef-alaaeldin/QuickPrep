//
//  Double+Extension.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 07/05/2025.
//

import Foundation

extension Double {
    /// Converts a score (expected between 0.0 and 1.0) into star rating (1.0 to 5.0)
    var starRating: Double {
        // Clamp score to [0, 1]
        let clampedScore = min(max(self, 0.0), 1.0)
        // Map to [1.0, 5.0] stars (double)
        return clampedScore * 4.0 + 1.0
    }
}

