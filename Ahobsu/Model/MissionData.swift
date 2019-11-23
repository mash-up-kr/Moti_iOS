//
//  Mission.swift
//  Ahobsu
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Foundation

struct MissionData: Decodable {
<<<<<<< HEAD
    let id: Int
=======
    let missionId: Int
>>>>>>> feat: 모델 추가
    let title: String
    let isContent: Bool
    let isImage: Bool

  enum CodingKeys: String, CodingKey {
<<<<<<< HEAD
    case id
=======
    case missionId
>>>>>>> feat: 모델 추가
    case title
    case isContent
    case isImage
  }
}
