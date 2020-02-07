//
//  Mission.swift
//  Ahobsu
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Foundation

struct TodayMission: Decodable, Identifiable {
    let id = UUID()
    let refresh: Bool
    let missions: [Mission]

    enum CodingKeys: String, CodingKey {
    case refresh
    case missions
    }
}

extension TodayMission: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
