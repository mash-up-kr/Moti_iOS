//
//  Mission.swift
//  Ahobsu
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Foundation

struct Mission: Decodable {
    let status: Int
    let error: String
    let message: String
    let data: [MissionData]

  enum CodingKeys: String, CodingKey {
    case status
    case error
    case message
    case data
  }
}
