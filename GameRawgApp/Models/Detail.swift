//
//  Detail.swift
//  GameRawgApp
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 04/08/24.
//

import Foundation

struct Detail: Codable, Hashable {
  let id: Int?
  let name, slug: String?
  let gamesCount: Int?
  let imageBackground: String?
  let backgroundImage: String?
  let description: String?
  
  enum CodingKeys: String, CodingKey {
    case id, name, slug
    case gamesCount = "games_count"
    case imageBackground = "image_background"
    case backgroundImage = "background_image"
    case description
  }
  
  public static func == (lhs: Detail, rhs: Detail) -> Bool {
    return lhs.id == rhs.id
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
