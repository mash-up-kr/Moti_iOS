//
//  Answer.swift
//  Ahobsu
//
//  Created by 김선재 on 01/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

struct Answer: Decodable, Identifiable {
    let id: Int
    let userId: Int
    let missionId: Int
    let imageUrl: String?
    var content: String?
    let date: String
    let setDate: String
    let mission: Mission
    let fileId: Int
    let file: FileModel
    let no: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case missionId
        case imageUrl
        case content
        case date
        case setDate
        case mission
        case fileId
        case file
        case no
    }
}

extension Answer: Hashable {
    static func == (lhs: Answer, rhs: Answer) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Answer {
    enum AnswerType {
        case essay
        case camera
        case essayCamera
    }
    
    func getAnswerType() -> AnswerType {
        if imageUrl == nil {
            return .essay
        } else {
            if mission.isContent {
                return .essayCamera
            } else {
                return .camera
            }
        }
    }
}

extension Answer {
    var dateForDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: date)
    }
    func isTodayAnswer() -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let todayStr = formatter.string(from: Date())
        
        return self.date == todayStr
    }
}

extension Answer {
    static func dummyCardView() -> [Answer] {
        var answersData: [Answer] = []
        
        for idx in 0...6 {
            answersData.append(
                Answer(id: idx,
                       userId: 0,
                       missionId: 0,
                       imageUrl: "https://wallpapershome.com/images/pages/pic_h/11603.jpg",
                       content: "Hello",
                       date: "2020-02-01",
                       setDate: "2020-02-01",
                       mission: Mission(id: 0, title: "더미 질문", isContent: true, isImage: true),
                       fileId: 0,
                       file: FileModel(id: 0,
                                       cardUrl: "",
                                       part: 1),
                       no: 1
                        )
            )
        }
        
        return answersData
    }

    static var sampleData: [Answer] {
        var answersData: [Answer] = []
        zip(1..<31, Mission.sampleData).forEach {
            let randomContent: [String?] = ["만수산 드렁칡이 얽혀진들 어떠하리 나랏말씀이 어떠한들 어떠하리 요렇큼 조렇쿰", .none]
            let newAnswer = Answer(id: $0.0,
                                   userId: 0,
                                   missionId: 0,
                                   imageUrl: "https://picsum.photos/375/200?grayscale",
                                   content: randomContent.randomElement()!,
                                   date: "2020-02-\($0.0)",
                                   setDate: "2020-02-\($0.0)",
                                   mission: $0.1,
                                   fileId: 0,
                                   file: FileModel(id: 0,
                                                   cardUrl: "",
                                                   part: 1),
                                   no: 1)
            answersData.append(newAnswer)
        }
        return answersData
    }
}
