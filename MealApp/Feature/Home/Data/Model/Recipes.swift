// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipes = try? JSONDecoder().decode(Recipes.self, from: jsonData)

import Foundation

// MARK: - Recipes
struct Recipes: Codable {
    let count: Int?
    let results: [Results]?
}

// MARK: - Result
struct Results: Codable {
    let approvedAt: Int?
    let aspectRatio: String?
    let beautyURL, brand, brandID: String?
    let buzzID: Int?
    let canonicalID: String?
    let compilations: [Compilation]?
    let cookTimeMinutes: Int?
    let country: Country?
    let createdAt: Int?
    let credits: [Credit]?
    let description: String?
    let draftStatus: DraftStatus?
    let facebookPosts: [String]?
    let id: Int?
    let inspiredByURL: String?
    let instructions: [Instruction]?
    let isAppOnly, isOneTop, isShoppable, isSubscriberContent: Bool?
    let keywords: String?
    let language: Language?
    let name: String?
    let numServings: Int?
    let nutrition: Nutrition?
    let nutritionVisibility: NutritionVisibility?
    let originalVideoURL: String?
    let prepTimeMinutes: Int?
    let price: Price?
    let promotion: Promotion?
    let renditions: [Rendition]?
    let sections: [Section]?
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
    let videoAdContent: VideoAdContent?
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
struct Compilation: Codable {
    let approvedAt: Int?
    let aspectRatio: String?
    let beautyURL: String?
    let buzzID: Int?
    let canonicalID: String?
    let country: Country?
    let createdAt: Int?
    let description: String?
    let draftStatus: DraftStatus?
    let facebookPosts: [String]?
    let id: Int?
    let isShoppable: Bool?
    let keywords: String?
    let language: Language?
    let name: String?
    let promotion: Promotion?
    let show: [Show]?
    let slug: String?
    let thumbnailAltText: ThumbnailAltText?
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

enum Country: String, Codable {
    case us = "US"
    case zz = "ZZ"
}

enum DraftStatus: String, Codable {
    case published = "published"
}

enum Language: String, Codable {
    case eng = "eng"
    case und = "und"
}

enum Promotion: String, Codable {
    case full = "full"
    case none = "none"
    case partial = "partial"
}

// MARK: - Show
struct Show: Codable {
    let id: Int?
    let name: RecipieName?
}

enum RecipieName: String, Codable {
    case goodful = "Goodful"
    case tasty = "Tasty"
    case tastyTastyJunior = "Tasty: Tasty Junior"
    case unknown // Fallback for unexpected values

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)
            self = RecipieName(rawValue: value) ?? .unknown
        }
}

enum ThumbnailAltText: String, Codable {
    case allYouNeedIsAMug = "All you need is a Mug!"
    case empty = ""
    case summerBreakRecipesForYourKids = "Summer Break Recipes For Your Kids"
    case tastyFoodForEveryMood = "Tasty Food For Every Mood"
}

// MARK: - Credit
struct Credit: Codable {
    let isVerified: Bool?
    let name: String?
    let pictureURL: String?
    let type: TypeEnum?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case isVerified = "is_verified"
        case name
        case pictureURL = "picture_url"
        case type
        case userID = "user_id"
    }
}

enum TypeEnum: String, Codable {
    case typeInternal = "internal"
    case community = "community"
}

// MARK: - Instruction
struct Instruction: Codable {
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
struct Hack: Codable {
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
struct Nutrition: Codable {
    let calories, carbohydrates, fat, fiber: Int?
    let protein, sugar: Int?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case calories, carbohydrates, fat, fiber, protein, sugar
        case updatedAt = "updated_at"
    }
}

enum NutritionVisibility: String, Codable {
    case auto = "auto"
}

// MARK: - Price
struct Price: Codable {
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
struct Rendition: Codable {
    let aspect: String?
    let bitRate: Int?
    let container: String?
    let contentType: ContentType?
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

enum ContentType: String, Codable {
    case applicationVndAppleMpegurl = "application/vnd.apple.mpegurl"
    case videoMp4 = "video/mp4"
}

// MARK: - Section
struct Section: Codable {
    let components: [Component]?
    let name: String?
    let position: Int?
}

// MARK: - Component
struct Component: Codable {
    let extraComment: String?
    let id: Int?
    let ingredient: Ingredient?
    let measurements: [Measurement]?
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
struct Ingredient: Codable {
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
struct Measurement: Codable {
    let id: Int?
    let quantity: String?
    let unit: Unit?
}

// MARK: - Unit
struct Unit: Codable {
    let abbreviation, displayPlural, displaySingular, name: String?
    let system: System?

    enum CodingKeys: String, CodingKey {
        case abbreviation
        case displayPlural = "display_plural"
        case displaySingular = "display_singular"
        case name, system
    }
}

enum System: String, Codable {
    case imperial = "imperial"
    case metric = "metric"
    case none = "none"
}

// MARK: - Tag
struct Tag: Codable {
    let displayName: String?
    let id: Int?
    let name: String?
    let parentTagName: String?
    let rootTagType: RootTagType?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case id, name
        case parentTagName = "parent_tag_name"
        case rootTagType = "root_tag_type"
        case type
    }
}

enum RootTagType: String, Codable {
    case appliance = "appliance"
    case businessTags = "business_tags"
    case cookingStyle = "cooking_style"
    case cuisine = "cuisine"
    case dietary = "dietary"
    case difficulty = "difficulty"
    case equipment = "equipment"
    case featurePage = "feature_page"
    case healthy = "healthy"
    case ingredientsToAvoid = "ingredients_to_avoid"
    case meal = "meal"
    case occasion = "occasion"
    case seasonal = "seasonal"
}

// MARK: - TipsSummary
struct TipsSummary: Codable {
    let byLine: ByLine?
    let content: String?
    let header: Header?

    enum CodingKeys: String, CodingKey {
        case byLine = "by_line"
        case content, header
    }
}

enum ByLine: String, Codable {
    case poweredByBotatouille = "Powered By Botatouille"
}

enum Header: String, Codable {
    case highlights = "Highlights"
}

// MARK: - Topic
struct Topic: Codable {
    let name, slug: String?
}

// MARK: - TotalTimeTier
struct TotalTimeTier: Codable {
    let displayTier: String?
    let tier: String?

    enum CodingKeys: String, CodingKey {
        case displayTier = "display_tier"
        case tier
    }
}

// MARK: - UserRatings
struct UserRatings: Codable {
    let countNegative, countPositive: Int?
    let score: Double?

    enum CodingKeys: String, CodingKey {
        case countNegative = "count_negative"
        case countPositive = "count_positive"
        case score
    }
}

enum VideoAdContent: String, Codable {
    case none = "none"
    case undetermined = "undetermined"
}
