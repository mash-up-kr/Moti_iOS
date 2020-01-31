//
//  AnswerQuestion.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/02/01.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Combine

class AnswerQuestion: ObservableObject {
    var cancels = Set<AnyCancellable>()
}

extension AnswerQuestion {
    struct Response {
        var status: Int
        var message: String
    }
}
