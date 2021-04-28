//
//  Mission.swift
//  Ahobsu
//
//  Created by 김선재 on 2019/11/24.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Foundation

struct Mission: Decodable, Identifiable {
    let uuid = UUID()
    let id: Int
    let title: String
    let isContent: Bool
    let isImage: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case isContent
        case isImage
    }
}

extension Mission {
    enum MissionType {
        case essay
        case camera
        case essayCamera
    }
    
     func getMissionType() -> MissionType {
        if !isImage {
            return .essay
        } else {
            if isContent {
                return .essayCamera
            } else {
                return .camera
            }
        }
    }
}

extension Mission: Hashable {
    static func == (lhs: Mission, rhs: Mission) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

extension Mission {
    static var sampleData: [Mission] {
        return ["오늘 비가와요.\n비가내리는 풍경을 찍어볼까요?",
                "당신이 좋아하는 음악 3가지를 적어주세요.",
                "소중한 사람에게 들려주고 싶은 노래는 무엇인가요?",
                "당신이 사용하고 있는 핸드폰의 모델은 무엇인가요?",
                "당신의 이름 한문으로 어떤 의미를 지니고 있나요?",
                "밤마다 문자하고 싶은 사람이 있다면 적어보아요."].map {
                    let contentType = [(true, true), (true, false), (false, true)].randomElement()!
                    return Mission(id: 0,
                                   title: $0,
                                   isContent: contentType.0,
                                   isImage: contentType.1)
                }
    }
}
