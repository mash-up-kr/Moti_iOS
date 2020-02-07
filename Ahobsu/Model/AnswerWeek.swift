//
//  AnswerWeek.swift
//  Ahobsu
//
//  Created by admin on 01/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

struct AnswerWeek: Decodable, Identifiable {
    let id = UUID()
    let today: String
    let answers: [Answer?]
    
    enum CodingKeys: String, CodingKey {
        case today
        case answers
    }
}

extension AnswerWeek: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
