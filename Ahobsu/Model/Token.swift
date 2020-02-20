//
//  RefreshToken.swift
//  Ahobsu
//
//  Created by 김선재 on 01/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

struct Token: Decodable, Identifiable {
    let id = UUID()
    let accessToken: String
    let refreshToken: String
    let signUp: Bool
    
    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
        case signUp
    }
}

extension Token: Hashable {
    static func == (lhs: Token, rhs: Token) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
