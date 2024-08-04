//
//  Game.swift
//  GameRawgApp
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 28/07/24.
//

import Foundation

// MARK: - Welcome
struct DataGame: Codable {
  let count: Int
  let next, previous: String?
  let results: [Result]
}

// MARK: - Result
struct Result: Codable, Hashable {
  let id: Int
  let slug, name, released: String?
  let tba: Bool?
  let backgroundImage: String?
  let rating, ratingTop: Double?
  let ratings: AddedByStatus?
  let ratingsCount: Int?
  let reviewsTextCount: Int?
  let added: Int?
  let addedByStatus: AddedByStatus?
  let metacritic, playtime, suggestionsCount: Int?
  let updated: String?
  let esrbRating: EsrbRating?
  let platforms: [Platform]?
  
  enum CodingKeys: String, CodingKey {
    case id, slug, name, released, tba
    case backgroundImage = "background_image"
    case rating
    case ratingTop = "rating_top"
    case ratings
    case ratingsCount = "ratings_count"
    case reviewsTextCount = "reviews_text_count"
    case added
    case addedByStatus = "added_by_status"
    case metacritic, playtime
    case suggestionsCount = "suggestions_count"
    case updated
    case esrbRating = "esrb_rating"
    case platforms
  }
  
  public static func == (lhs: Result, rhs: Result) -> Bool {
    return lhs.id == rhs.id
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
  let id: Int
  let slug, name: String?
}

// MARK: - Platform
struct Platform: Codable {
  let platform: EsrbRating?
  let releasedAt: String?
  let requirements: Requirements?
  
  enum CodingKeys: String, CodingKey {
    case platform
    case releasedAt = "released_at"
    case requirements
  }
}

// MARK: - Requirements
struct Requirements: Codable {
  let minimum, recommended: String?
}
