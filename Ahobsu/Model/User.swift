//
//  User.swift
//  Ahobsu
//
//  Created by 김선재 on 2020/01/12.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

struct User: Decodable, Identifiable {
    let id: Int
    var birthday: String
    let email: String
    var name: String
    var gender: String
    let refreshDate: String?
    let refreshToken: String?
    let mission: String? // Mission?
    let snsId: String
    let snsType: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case birthday
        case email
        case name
        case gender
        case refreshDate
        case refreshToken
        case mission
        case snsId
        case snsType
    }
}

extension User: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension User {
    static var placeholderData: User {
        return User(id: 0,
                    birthday: "-",
                    email: "-",
                    name: "-",
                    gender: "-",
                    refreshDate: nil,
                    refreshToken: nil,
                    mission: nil,
                    snsId: "1",
                    snsType: "-")
    }
}

extension User: Equatable {
}
