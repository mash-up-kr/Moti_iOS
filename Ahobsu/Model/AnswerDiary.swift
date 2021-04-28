//
//  AnswerDiary.swift
//  Ahobsu
//
//  Created by bran.new on 2021/03/23.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import Foundation

struct AnswerDiary: Decodable {

    let answers: [Answer]

    enum CodingKeys: String, CodingKey {
        case answers
    }
}
