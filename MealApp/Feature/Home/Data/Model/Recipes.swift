// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipes = try? JSONDecoder().decode(Recipes.self, from: jsonData)

import Foundation

// MARK: - Recipes
struct RecipesResponse: Codable {
    let count: Int?
    let results: [Recipie]
}

// MARK: - Result
struct Recipie: Codable, Equatable {
    
    let approvedAt: Int?
    let aspectRatio: String?
    let beautyURL, brand, brandID: String?
    let buzzID: Int?
    let canonicalID: String?
    let compilations: [Compilation]?
    let cookTimeMinutes: Int?
    let country: String?
    let createdAt: Int?
    let credits: [Credit]?
    let description: String?
    let draftStatus: String?
    let facebookPosts: [String]?
    let id: Int?
    let inspiredByURL: String?
    let instructions: [Instruction]?
    let isAppOnly, isOneTop, isShoppable, isSubscriberContent: Bool?
    let keywords: String?
    let language: String?
    let name: String?
    let numServings: Int?
    let nutrition: Nutrition?
    let nutritionVisibility: String?
    let originalVideoURL: String?
    let prepTimeMinutes: Int?
    let price: Price?
    let promotion: String?
    let renditions: [Rendition]?
    let sections: [MealSection]?
    let seoPath: String?
    let seoTitle: String?
    let servingsNounPlural: String?
    let servingsNounSingular: String?
    let show: Show?
    let showID: Int?
    let slug: String?
    let tags: [Tag]?
    let thumbnailAltText: String?
    let thumbnailURL: String?
    let tipsAndRatingsEnabled: Bool?
    let topics: [Topic]?
    let totalTimeMinutes: Int?
    let totalTimeTier: TotalTimeTier?
    let updatedAt: Int?
    let userRatings: UserRatings?
    let videoAdContent: String?
    let videoID: Int?
    let videoURL: String?
    let yields: String?
    let tipsSummary: TipsSummary?

    enum CodingKeys: String, CodingKey {
        case approvedAt = "approved_at"
        case aspectRatio = "aspect_ratio"
        case beautyURL = "beauty_url"
        case brand
        case brandID = "brand_id"
        case buzzID = "buzz_id"
        case canonicalID = "canonical_id"
        case compilations
        case cookTimeMinutes = "cook_time_minutes"
        case country
        case createdAt = "created_at"
        case credits, description
        case draftStatus = "draft_status"
        case facebookPosts = "facebook_posts"
        case id
        case inspiredByURL = "inspired_by_url"
        case instructions
        case isAppOnly = "is_app_only"
        case isOneTop = "is_one_top"
        case isShoppable = "is_shoppable"
        case isSubscriberContent = "is_subscriber_content"
        case keywords, language, name
        case numServings = "num_servings"
        case nutrition
        case nutritionVisibility = "nutrition_visibility"
        case originalVideoURL = "original_video_url"
        case prepTimeMinutes = "prep_time_minutes"
        case price, promotion, renditions, sections
        case seoPath = "seo_path"
        case seoTitle = "seo_title"
        case servingsNounPlural = "servings_noun_plural"
        case servingsNounSingular = "servings_noun_singular"
        case show
        case showID = "show_id"
        case slug, tags
        case thumbnailAltText = "thumbnail_alt_text"
        case thumbnailURL = "thumbnail_url"
        case tipsAndRatingsEnabled = "tips_and_ratings_enabled"
        case topics
        case totalTimeMinutes = "total_time_minutes"
        case totalTimeTier = "total_time_tier"
        case updatedAt = "updated_at"
        case userRatings = "user_ratings"
        case videoAdContent = "video_ad_content"
        case videoID = "video_id"
        case videoURL = "video_url"
        case yields
        case tipsSummary = "tips_summary"
    }
}

// MARK: - Compilation
struct Compilation: Codable, Equatable {
    let approvedAt: Int?
    let aspectRatio: String?
    let beautyURL: String?
    let buzzID: Int?
    let canonicalID: String?
    let country: String?
    let createdAt: Int?
    let description: String?
    let draftStatus: String?
    let facebookPosts: [String]?
    let id: Int?
    let isShoppable: Bool?
    let keywords: String?
    let language: String?
    let name: String?
    let promotion: String?
    let show: [Show]?
    let slug: String?
    let thumbnailAltText: String?
    let thumbnailURL: String?
    let videoID: Int?
    let videoURL: String?

    enum CodingKeys: String, CodingKey {
        case approvedAt = "approved_at"
        case aspectRatio = "aspect_ratio"
        case beautyURL = "beauty_url"
        case buzzID = "buzz_id"
        case canonicalID = "canonical_id"
        case country
        case createdAt = "created_at"
        case description
        case draftStatus = "draft_status"
        case facebookPosts = "facebook_posts"
        case id
        case isShoppable = "is_shoppable"
        case keywords, language, name, promotion, show, slug
        case thumbnailAltText = "thumbnail_alt_text"
        case thumbnailURL = "thumbnail_url"
        case videoID = "video_id"
        case videoURL = "video_url"
    }
}

// MARK: - Show
struct Show: Codable, Equatable {
    let id: Int?
    let name: String?
}

// MARK: - Credit
struct Credit: Codable, Equatable {
    let isVerified: Bool?
    let name: String?
    let pictureURL: String?
    let type: String?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case isVerified = "is_verified"
        case name
        case pictureURL = "picture_url"
        case type
        case userID = "user_id"
    }
}

// MARK: - Instruction
struct Instruction: Codable, Equatable {
    let appliance: String?
    let displayText: String?
    let endTime, id, position, startTime: Int?
    let temperature: Int?
    let hacks: [Hack]?

    enum CodingKeys: String, CodingKey {
        case appliance
        case displayText = "display_text"
        case endTime = "end_time"
        case id, position
        case startTime = "start_time"
        case temperature, hacks
    }
}

// MARK: - Hack
struct Hack: Codable, Equatable {
    let endIndex, id: Int?
    let match: String?
    let startIndex: Int?

    enum CodingKeys: String, CodingKey {
        case endIndex = "end_index"
        case id, match
        case startIndex = "start_index"
    }
}

// MARK: - Nutrition
struct Nutrition: Codable, Equatable {
    let calories, carbohydrates, fat, fiber: Int?
    let protein, sugar: Int?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case calories, carbohydrates, fat, fiber, protein, sugar
        case updatedAt = "updated_at"
    }
}

// MARK: - Price
struct Price: Codable, Equatable {
    let consumptionPortion, consumptionTotal, portion, total: Int?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case consumptionPortion = "consumption_portion"
        case consumptionTotal = "consumption_total"
        case portion, total
        case updatedAt = "updated_at"
    }
}

// MARK: - Rendition
struct Rendition: Codable, Equatable {
    let aspect: String?
    let bitRate: Int?
    let container: String?
    let contentType: String?
    let duration: Int?
    let fileSize: Int?
    let height: Int?
    let maximumBitRate, minimumBitRate: Int?
    let name: String?
    let posterURL: String?
    let url: String?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case aspect
        case bitRate = "bit_rate"
        case container
        case contentType = "content_type"
        case duration
        case fileSize = "file_size"
        case height
        case maximumBitRate = "maximum_bit_rate"
        case minimumBitRate = "minimum_bit_rate"
        case name
        case posterURL = "poster_url"
        case url, width
    }
}

// MARK: - Section
struct MealSection: Codable , Equatable{
    let components: [MealComponent]?
    let name: String?
    let position: Int?
}

// MARK: - Component
struct MealComponent: Codable, Equatable {
    let extraComment: String?
    let id: Int?
    let ingredient: Ingredient?
    let measurements: [RecipeMeasurement]?
    let position: Int?
    let rawText: String?
    let hacks: [Hack]?

    enum CodingKeys: String, CodingKey {
        case extraComment = "extra_comment"
        case id, ingredient, measurements, position
        case rawText = "raw_text"
        case hacks
    }
}

// MARK: - Ingredient
struct Ingredient: Codable, Equatable {
    let createdAt: Int?
    let displayPlural, displaySingular: String?
    let id: Int?
    let name: String?
    let updatedAt: Int?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case displayPlural = "display_plural"
        case displaySingular = "display_singular"
        case id, name
        case updatedAt = "updated_at"
    }
}

// MARK: - Measurement
struct RecipeMeasurement: Codable, Equatable {
    let id: Int?
    let quantity: String?
    let unit: Unit?
}

// MARK: - Unit
struct Unit: Codable, Equatable {
    let abbreviation, displayPlural, displaySingular, name: String?
    let system: String?

    enum CodingKeys: String, CodingKey {
        case abbreviation
        case displayPlural = "display_plural"
        case displaySingular = "display_singular"
        case name, system
    }
}

// MARK: - Tag
struct Tag: Codable, Equatable {
    let displayName: String?
    let id: Int?
    let name: String?
    let parentTagName: String?
    let rootTagType: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case id, name
        case parentTagName = "parent_tag_name"
        case rootTagType = "root_tag_type"
        case type
    }
}

// MARK: - TipsSummary
struct TipsSummary: Codable, Equatable {
    let byLine: String?
    let content: String?
    let header: String?

    enum CodingKeys: String, CodingKey {
        case byLine = "by_line"
        case content, header
    }
}

// MARK: - Topic
struct Topic: Codable , Equatable{
    let name, slug: String?
}

// MARK: - TotalTimeTier
struct TotalTimeTier: Codable, Equatable {
    let displayTier: String?
    let tier: String?

    enum CodingKeys: String, CodingKey {
        case displayTier = "display_tier"
        case tier
    }
}

// MARK: - UserRatings
struct UserRatings: Codable, Equatable {
    let countNegative, countPositive: Int?
    let score: Double?

    enum CodingKeys: String, CodingKey {
        case countNegative = "count_negative"
        case countPositive = "count_positive"
        case score
    }
}
