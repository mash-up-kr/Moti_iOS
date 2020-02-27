//
//  FileModel.swift
//  Ahobsu
//
//  Created by 김선재 on 2020/02/27.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Foundation

struct FileModel: Decodable, Identifiable {
    let id: Int
    let cardUrl: String
    let part: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case cardUrl
        case part
    }
}

extension FileModel: Hashable {
    static func == (lhs: FileModel, rhs: FileModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
