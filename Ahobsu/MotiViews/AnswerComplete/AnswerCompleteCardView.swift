//
//  AnswerCompleteCardView.swift
//  Ahobsu
//
//  Created by 김선재 on 2019/12/21.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI
import Combine

struct AnswerCompleteCardView: View, Identifiable {
    
    var id: Int { return answer?.id ?? 0 }
    
    @State var answer: Answer?
    
    var contentView: some View {
        if let answer = self.answer {
            switch answer.getAnswerType() {
                case .essay:
                    return AnyView(AnswerComplete_Essay(title: answer.mission.title, text: answer.content ?? ""))
                case .camera:
                    return AnyView(AnswerComplete_Camera(title: answer.mission.title, imageURL: answer.imageUrl ?? ""))
                case .essayCamera:
                    return AnyView(AnswerComplete_EssayCamera(title: answer.mission.title,
                                                              text: answer.content ?? "",
                                                              imageURL: answer.imageUrl ?? ""))
            }
        } else {
            return AnyView(Text(""))
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                contentView
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 480.0, maxHeight: 480.0)
            }
            .clipped()
            
            .padding([.bottom], 32.0)
        }
    }
    
    func update() {
        switch answer?.getAnswerType() {
        case .essay:
            break
        case .camera:
            break
        case .essayCamera:
            break
        default:
            break
        }
    }
}

struct AnswerCompleteCardView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerCompleteCardView(
            answer: Answer.dummyCardView()[0])
    }
}
