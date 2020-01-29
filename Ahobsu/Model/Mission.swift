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
    let message: String
    let data: Data

  enum CodingKeys: String, CodingKey {
    case status
    case message
    case data
  }
    
    struct Data: Decodable {
        let refresh: Bool
        let missions: [MissionData]
    }
}
