//
//  OnBordingModel.swift
//  Ahobsu
//
//  Created by 김선재 on 29/01/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

struct OnBordingModel: Codable, Identifiable {
    let id = UUID()
    let headline: String
    let detail: String
    let imageName: String
    
    enum enumCodingKeys: String, CodingKey {
        case headline
        case detail
        case imageName
    }
}

extension OnBordingModel: Hashable {
    static func == (lhs: OnBordingModel, rhs: OnBordingModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension OnBordingModel {
    
    static func createOnBordingModel() -> [OnBordingModel] {
        var onBordingData: [OnBordingModel] = []
        
        onBordingData.append(
            OnBordingModel(headline: "매일 나에 대한 새로운 질문", detail: "하루에 받는 질문 3개 중 마음에 드는 질문을 선택하세요.\n질문은 하루 한 번 씩 다시 받기 가능합니다.", imageName: "onbording1")
        )
        
        onBordingData.append(
            OnBordingModel(headline: "나를 기록하기", detail: "사진, 글 등으로 답할 수 있는 질문에 대답하며\n나를 기록하는 시간을 가져보세요.", imageName: "onbording2")
        )
        
        onBordingData.append(
            OnBordingModel(headline: "나만의 드림캐쳐 만들기", detail: "질문에 답변해 파츠를 하나씩 모으세요.\n6일간의 기록을 통해 나만의 드림캐쳐가 완성됩니다.", imageName: "onbording3")
        )
        
        onBordingData.append(
            OnBordingModel(headline: "리마인더", detail: "앨범에서 지금까지 모은 드림캐쳐와\n기록을 다시 확인할 수 있어요.", imageName: "onbording4")
        )
        
        return onBordingData
    }
    
}
