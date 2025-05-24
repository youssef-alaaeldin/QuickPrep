//
//  RecipiesMock.swift
//  MealApp
//
//  Created by Yousuf Abdelfattah on 07/05/2025.
//

import Foundation

// MARK: - Mock Data Extensions

extension RecipesResponse {
    static var mock: RecipesResponse {
        RecipesResponse(
            count: Int.random(in: 1...100),
            results: Recipie.mockArray(count: Int.random(in: 2...5))
        )
    }

    static func mockArray(count: Int) -> [RecipesResponse] {
        (1...count).map { _ in RecipesResponse.mock }
    }
}

extension Recipie {
    static var mock: Recipie {
        Recipie(
            approvedAt: Int.random(in: 1600000000...1700000000),
            aspectRatio: "16:9",
            buzzID: Int.random(in: 1...1000),
            canonicalID: "recipe_\(Int.random(in: 1...10000))",
            compilations: Compilation.mockArray(count: Int.random(in: 0...2)),
            cookTimeMinutes: Int.random(in: 5...60),
            country: "US",
            createdAt: Int.random(in: 1600000000...1700000000),
            credits: Credit.mockArray(count: Int.random(in: 1...2)),
            description: "A delicious mock recipe description asdada sd asd asdasd asd asd asd asd asda sdwadqwdeqweq w eqe qwe qwe qwe qdasd qwdqeq wasd asd qwe qasd asd.",
            draftStatus: "published",
            facebookPosts: [],
            id: Int.random(in: 1...10000),
            inspiredByURL: "https://example.com/inspiration",
            instructions: Instruction.mockArray(count: Int.random(in: 2...6)),
            isAppOnly: Bool.random(),
            isOneTop: Bool.random(),
            isShoppable: Bool.random(),
            isSubscriberContent: Bool.random(),
            keywords: "easy, quick, tasty",
            language: "en",
            name: "Mock Recipe \(Int.random(in: 1...100))",
            numServings: Int.random(in: 1...8),
            nutrition: Nutrition.mock,
            nutritionVisibility: "auto",
            originalVideoURL: "https://example.com/video.mp4",
            prepTimeMinutes: Int.random(in: 5...30),
            price: Price.mock,
            promotion: "community",
            renditions: Rendition.mockArray(count: Int.random(in: 1...2)),
            sections: MealSection.mockArray(count: Int.random(in: 1...2)),
            seoPath: "/recipes/mock-recipe",
            seoTitle: "Mock SEO Title",
            servingsNounPlural: "servings",
            servingsNounSingular: "serving",
            show: Show.mock,
            showID: Int.random(in: 1...1000),
            slug: "mock-recipe",
            tags: Tag.mockArray(count: Int.random(in: 2...4)),
            thumbnailAltText: "A mock recipe image",
            thumbnailURL: "https://example.com/image.jpg",
            tipsAndRatingsEnabled: Bool.random(),
            topics: Topic.mockArray(count: Int.random(in: 1...3)),
            totalTimeMinutes: Int.random(in: 20...120),
            totalTimeTier: TotalTimeTier.mock,
            updatedAt: Int.random(in: 1600000000...1700000000),
            userRatings: UserRatings.mock,
            videoAdContent: "none",
            videoID: Int.random(in: 1000...2000),
            videoURL: "https://example.com/video.mp4",
            yields: "Serves \(Int.random(in: 2...8))",
            tipsSummary: TipsSummary.mock
        )
    }

    static func mockArray(count: Int) -> [Recipie] {
        (1...count).map { _ in Recipie.mock }
    }
}

extension Compilation {
    static var mock: Compilation {
        Compilation(
            approvedAt: Int.random(in: 1600000000...1700000000),
            aspectRatio: "1:1",
            beautyURL: "https://example.com/compilation.mp4",
            buzzID: Int.random(in: 100...500),
            canonicalID: "compilation_\(Int.random(in: 1...500))",
            country: "US",
            createdAt: Int.random(in: 1600000000...1700000000),
            description: "Mock compilation description",
            draftStatus: "published",
            facebookPosts: [],
            id: Int.random(in: 1...1000),
            isShoppable: Bool.random(),
            keywords: "mock, test",
            language: "en",
            name: "Mock Compilation",
            promotion: "full",
            show: [Show.mock],
            slug: "mock-compilation",
            thumbnailAltText: "Compilation thumbnail",
            thumbnailURL: "https://example.com/thumbnail.jpg",
            videoID: Int.random(in: 1000...2000),
            videoURL: "https://example.com/compilation-video.mp4"
        )
    }

    static func mockArray(count: Int) -> [Compilation] {
        (1..<10).map { _ in Compilation.mock }
    }
}

extension Credit {
    static var mock: Credit {
        Credit(
            isVerified: Bool.random(),
            name: "Mock Credit Name",
            pictureURL: "https://example.com/avatar.jpg",
            type: "internal",
            userID: Int.random(in: 1...1000)
        )
    }

    static func mockArray(count: Int) -> [Credit] {
        (1...count).map { _ in Credit.mock }
    }
}

extension Instruction {
    static var mock: Instruction {
        Instruction(
            appliance: "oven",
            displayText: "Step \(Int.random(in: 1...5)): Do something.",
            endTime: Int.random(in: 10...100),
            id: Int.random(in: 1...1000),
            position: Int.random(in: 1...10),
            startTime: Int.random(in: 0...50),
            temperature: Int.random(in: 150...220),
            hacks: Hack.mockArray(count: Int.random(in: 0...1))
        )
    }

    static func mockArray(count: Int) -> [Instruction] {
        (1...count).map { _ in Instruction.mock }
    }
}

extension Hack {
    static var mock: Hack {
        Hack(
            endIndex: Int.random(in: 10...50),
            id: Int.random(in: 1...100),
            match: "Mock Hack Match",
            startIndex: Int.random(in: 1...9)
        )
    }

    static func mockArray(count: Int) -> [Hack] {
        (1..<10).map { _ in Hack.mock }
    }
}

extension Nutrition {
    static var mock: Nutrition {
        Nutrition(
            calories: Int.random(in: 200...800),
            carbohydrates: Int.random(in: 20...100),
            fat: Int.random(in: 10...60),
            fiber: Int.random(in: 1...15),
            protein: Int.random(in: 10...50),
            sugar: Int.random(in: 5...40),
            updatedAt: "2024-05-01T12:34:56Z"
        )
    }
}

extension Price {
    static var mock: Price {
        Price(
            consumptionPortion: Int.random(in: 1...3),
            consumptionTotal: Int.random(in: 3...12),
            portion: Int.random(in: 1...5),
            total: Int.random(in: 5...20),
            updatedAt: "2024-05-01T12:34:56Z"
        )
    }
}

extension Rendition {
    static var mock: Rendition {
        Rendition(
            aspect: "16:9",
            bitRate: Int.random(in: 500...1500),
            container: "mp4",
            contentType: "video/mp4",
            duration: Int.random(in: 10...60),
            fileSize: Int.random(in: 1000000...5000000),
            height: 720,
            maximumBitRate: Int.random(in: 1000...2000),
            minimumBitRate: Int.random(in: 500...999),
            name: "Mock Rendition",
            posterURL: "https://example.com/poster.jpg",
            url: "https://example.com/rendition.mp4",
            width: 1280
        )
    }

    static func mockArray(count: Int) -> [Rendition] {
        (1...count).map { _ in Rendition.mock }
    }
}

extension MealSection {
    static var mock: MealSection {
        MealSection(
            components: MealComponent.mockArray(count: Int.random(in: 2...4)),
            name: "Section Name",
            position: Int.random(in: 1...3)
        )
    }

    static func mockArray(count: Int) -> [MealSection] {
        (1...count).map { _ in MealSection.mock }
    }
}

extension MealComponent {
    static var mock: MealComponent {
        MealComponent(
            extraComment: "Optional comment",
            id: Int.random(in: 1...1000),
            ingredient: Ingredient.mock,
            measurements: RecipeMeasurement.mockArray(count: 1),
            position: Int.random(in: 1...5),
            rawText: "2 cups flour",
            hacks: Hack.mockArray(count: Int.random(in: 0...1))
        )
    }

    static func mockArray(count: Int) -> [MealComponent] {
        (1...count).map { _ in MealComponent.mock }
    }
}

extension Ingredient {
    static var mock: Ingredient {
        Ingredient(
            createdAt: Int.random(in: 1600000000...1700000000),
            displayPlural: "mock ingredients",
            displaySingular: "mock ingredient",
            id: Int.random(in: 1...500),
            name: "Flour",
            updatedAt: Int.random(in: 1600000000...1700000000)
        )
    }
}

extension RecipeMeasurement {
    static var mock: RecipeMeasurement {
        RecipeMeasurement(
            id: Int.random(in: 1...1000),
            quantity: "\(Int.random(in: 1...5))",
            unit: Unit.mock
        )
    }

    static func mockArray(count: Int) -> [RecipeMeasurement] {
        (1...count).map { _ in RecipeMeasurement.mock }
    }
}

extension Unit {
    static var mock: Unit {
        Unit(
            abbreviation: "cup",
            displayPlural: "cups",
            displaySingular: "cup",
            name: "cup",
            system: "imperial"
        )
    }
}

extension Tag {
    static var mock: Tag {
        Tag(
            displayName: "Easy",
            id: Int.random(in: 1...100),
            name: "easy",
            parentTagName: nil,
            rootTagType: "difficulty",
            type: "difficulty"
        )
    }

    static func mockArray(count: Int) -> [Tag] {
        (1...count).map { _ in Tag.mock }
    }
}

extension TipsSummary {
    static var mock: TipsSummary {
        TipsSummary(
            byLine: "Mock user",
            content: "This is a great tip for making this recipe!",
            header: "Pro Tips"
        )
    }
}

extension Topic {
    static var mock: Topic {
        Topic(
            name: "Dinner",
            slug: "dinner"
        )
    }

    static func mockArray(count: Int) -> [Topic] {
        (1...count).map { _ in Topic.mock }
    }
}

extension TotalTimeTier {
    static var mock: TotalTimeTier {
        TotalTimeTier(
            displayTier: "Under 1 hour",
            tier: "under_1_hour"
        )
    }
}

extension UserRatings {
    static var mock: UserRatings {
        UserRatings(
            countNegative: Int.random(in: 0...50),
            countPositive: Int.random(in: 50...500),
            score: Double.random(in: 0.5...5.0)
        )
    }
}

extension Show {
    static var mock: Show {
        Show(
            id: Int.random(in: 1...1000),
            name: "Mock Show"
        )
    }
}
