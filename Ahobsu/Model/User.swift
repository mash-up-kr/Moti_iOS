//
//  User.swift
//  Ahobsu
//
//  Created by admin on 2020/01/12.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

struct User: Decodable {
    var id: Int
    var birthday: String
    var email: String
    var name: String
    var gender: String
    var refreshDate: String?
    var refreshToken: String?
    var mission: [Mission]?
    var snsId: Int
    var snsType: String
    
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
                    snsId: 1,
                    snsType: "-")
    }
}
