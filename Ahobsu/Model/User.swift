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
    static var sampleData: User {
        return User(id: 0,
                    birthday: "1990-09-05",
                    email: "kimyuna90@gmail.com",
                    name: "얼음판위의연아킴",
                    gender: "여",
                    refreshDate: nil,
                    refreshToken: nil,
                    mission: nil,
                    snsId: 1,
                    snsType: "google")
    }
}
