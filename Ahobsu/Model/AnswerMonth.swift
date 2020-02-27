//
//  AnswerWeek.swift
//  Ahobsu
//
//  Created by 김선재 on 01/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

struct AnswerMonth: Decodable, Identifiable {
    let id = UUID()
    let date: String
    let monthAnswer: [[Answer?]]
    
    enum CodingKeys: String, CodingKey {
        case date
        case monthAnswer
    }
}

extension AnswerMonth: Hashable {
    static func == (lhs: AnswerMonth, rhs: AnswerMonth) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
