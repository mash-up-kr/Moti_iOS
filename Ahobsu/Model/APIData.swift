//
//  APIData.swift
//  Ahobsu
//
//  Created by 김선재 on 01/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

struct APIData<T : Decodable>: Decodable, Identifiable {
    let id = UUID()
    let status: Int?
    let message: String?
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }
}

extension APIData: Hashable {
    static func == (lhs: APIData, rhs: APIData) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ErrorCodeMsg: Decodable {
    let msg: String?
    let code: Int?
}

