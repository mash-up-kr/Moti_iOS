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
                    return AnyView(AnswerComplete_Essay(text: answer.content ?? ""))
                case .camera:
                    return AnyView(AnswerComplete_Camera(imageURL: answer.imageUrl ?? ""))
                case .essayCamera:
                    return AnyView(AnswerComplete_EssayCamera(text: answer.content ?? "",
                                                              imageURL: answer.imageUrl ?? ""))
            }
        } else {
            return AnyView(Text(""))
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(answer?.mission.title ?? "")
                            .font(.custom("IropkeBatangM", size: 24.0))
                            .foregroundColor(Color(UIColor.rosegold))
                            .lineSpacing(12.0)
                        Spacer()
                        if answer?.isTodayAnswer() == true {
                            Button(action: update) {
                                Image("icRewriteNormal")
                                    .renderingMode(.original)
                                    .frame(width: 48.0, height: 48.0)
                            }
                        }
                    }
                    .padding([.leading], 20.0)
                    .padding([.trailing], 4.0)
                    VStack {
                        contentView
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 480.0, maxHeight: 480.0)
                    }
                    .padding([.leading, .trailing, .bottom], 32.0)
                    .padding([.top], 56.0)
                }
            }
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
