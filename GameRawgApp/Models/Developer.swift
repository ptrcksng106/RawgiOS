//
//  Developer.swift
//  GameRawgApp
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 03/08/24.
//

import Foundation

struct DataDeveloper: Codable {
  let count: Int?
  let next, previous: String?
  let developers: [Developer]
  
  enum CodingKeys: String, CodingKey {
    case count, next, previous
    case developers = "results"
  }
}

struct Developer: Codable, Hashable {
  let id: Int?
  let name, slug: String?
  let gamesCount: Int?
  let imageBackground: String?
  
  enum CodingKeys: String, CodingKey {
    case id, name, slug
    case gamesCount = "games_count"
    case imageBackground = "image_background"
  }
  
  public static func == (lhs: Developer, rhs: Developer) -> Bool {
    return lhs.id == rhs.id
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
