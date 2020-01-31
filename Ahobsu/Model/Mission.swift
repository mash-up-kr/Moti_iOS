//
//  Mission.swift
//  Ahobsu
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Foundation

struct Mission: Decodable {
    let refresh: Bool
    let missions: [MissionData]

    enum CodingKeys: String, CodingKey {
    case refresh
    case missions
    }
}
