//
//  AnswerCompleteModel.swift
//  Ahobsu
//
//  Created by admin on 2019/12/21.
//  Copyright © 2019 ahobsu. All rights reserved.
//

struct AnswerCompleteModel: Hashable, Codable {

    var answerId: Int
    var question: String
    var answer: String
    var answerCompleteType: AnswerCompleteType

    var imageURL: String

    var date: String

}

extension AnswerCompleteModel {
    enum AnswerCompleteType: String, CaseIterable, Codable, Hashable {
        case essay = "Essay"
        case camera = "Camera"
        case essayCamera = "EssayCamera"
    }
}

extension AnswerCompleteModel {

    static func dummyCardView() -> [AnswerCompleteModel] {
        var answerCompleteData: [AnswerCompleteModel] = []

        for idx in 0...7 {
            answerCompleteData.append(
                 AnswerCompleteModel(
                    answerId: idx,
                    question: "Test \(idx)",
                    answer: "Answer \(idx)",
                    answerCompleteType: AnswerCompleteType.allCases.randomElement()!,
                    imageURL: "https://wallpapershome.com/images/pages/pic_h/11603.jpg",
                    date: "2019. Nov. \(21 + idx)"
                )
            )
        }

        return answerCompleteData
    }

}
