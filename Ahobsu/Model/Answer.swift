//
//  Answer.swift
//  Ahobsu
//
//  Created by admin on 01/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

struct Answer: Decodable, Identifiable {
    let id: Int
    let userId: Int
    let missionId: Int
    let imageUrl: String?
    let cardUrl: String
    var content: String
    let date: String
    let mission: Mission

  enum CodingKeys: String, CodingKey {
    case id
    case userId
    case missionId
    case imageUrl
    case cardUrl
    case content
    case date
    case mission
  }
}

extension Answer: Hashable {
    static func == (lhs: Answer, rhs: Answer) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
