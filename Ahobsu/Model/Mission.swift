//
//  Mission.swift
//  Ahobsu
//
//  Created by 김선재 on 2019/11/24.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Foundation

struct Mission: Decodable, Identifiable {
    let id: Int
    let title: String
    let isContent: Bool
    let isImage: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case isContent
        case isImage
    }
}

extension Mission {
    enum MissionType {
        case essay
        case camera
        case essayCamera
    }
    
     func getMissionType() -> MissionType {
        if !isImage {
            return .essay
        } else {
            if isContent {
                return .essayCamera
            } else {
                return .camera
            }
        }
    }
}

extension Mission: Hashable {
    static func == (lhs: Mission, rhs: Mission) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
