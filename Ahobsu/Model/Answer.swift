//
//  Answer.swift
//  Ahobsu
//
//  Created by 한종호 on 01/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

struct Answer: Decodable {
    var id: Int
    var userId: Int
    var missionId: Int
    var imageUrl: String
    var cardUrl: String
    var content: String
    var date: String
    var mission: [MissionData]

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
