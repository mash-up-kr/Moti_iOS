//
//  User.swift
//  Ahobsu
//
//  Created by admin on 2020/01/12.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

class User {
    var name: String
    var birthday: String
    var email: String
    var gender: String
    var snsId: Int
    var snsType: String

    init(name: String,
         birthday: String,
         email: String,
         gender: String,
         snsId: Int,
         snsType: String) {
        self.name = name
        self.birthday = birthday
        self.email = email
        self.gender = gender
        self.snsId = snsId
        self.snsType = snsType
    }
}

extension User {
    static var sampleData: User {
        return User(name: "얼음판위의연아킴",
                    birthday: "1990-09-05",
                    email: "kimyuna90@gmail.com",
                    gender: "여",
                    snsId: 1,
                    snsType: "google")
    }
}
