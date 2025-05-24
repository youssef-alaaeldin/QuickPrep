//
//  Category.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 12/05/2025.
//

import Foundation

// MARK: - TagsResponse
struct CategoryResponse: Codable, Equatable {
    let count: Int?
    let results: [Categories]?
}

// MARK: - Result
struct Categories: Codable, Equatable {
    let displayName: String?
    let id: Int?
    let name: String?
    let parentTagName: String?
    let rootTagType, type: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case id, name
        case parentTagName = "parent_tag_name"
        case rootTagType = "root_tag_type"
        case type
    }
}

// MARK: - Mock Data Extensions for Categories

extension Categories {
    static var mock: Categories {
        Categories(
            displayName: "Mock Category \(Int.random(in: 1...10))",
            id: Int.random(in: 1...1000),
            name: "mock_category_\(Int.random(in: 1...10))",
            parentTagName: Bool.random() ? "parent_category" : nil,
            rootTagType: ["cuisine", "meal_type", "difficulty"].randomElement()!,
            type: "category"
        )
    }

    static func mockArray(count: Int) -> [Categories] {
        (1...count).map { _ in Categories.mock }
    }
}

// MARK: - Mock Data Extensions for CategoryResponse

extension CategoryResponse {
    static var mock: CategoryResponse {
        CategoryResponse(
            count: Int.random(in: 1...10),
            results: Categories.mockArray(count: Int.random(in: 2...5))
        )
    }

    static func mockArray(count: Int) -> [CategoryResponse] {
        (1...count).map { _ in CategoryResponse.mock }
    }
}
