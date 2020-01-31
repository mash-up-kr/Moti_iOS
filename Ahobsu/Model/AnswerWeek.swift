//
//  AnswerWeek.swift
//  Ahobsu
//
//  Created by 한종호 on 01/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

struct AnswerWeek: Decodable {
    var today: String
    var answers: [Answer?]

  enum CodingKeys: String, CodingKey {
    case today
    case answers
  }
}
