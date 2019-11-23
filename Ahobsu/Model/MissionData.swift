//
//  Mission.swift
//  Ahobsu
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Foundation

struct MissionData: Decodable {
    let missionId: Int
    let title: String
    let isContent: Bool
    let isImage: Bool

  enum CodingKeys: String, CodingKey {
    case missionId
    case title
    case isContent
    case isImage
  }
}
