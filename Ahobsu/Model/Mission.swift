//
//  Mission.swift
//  Ahobsu
//
//  Created by admin on 2019/11/24.
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

extension Mission: Hashable {
    static func == (lhs: Mission, rhs: Mission) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
