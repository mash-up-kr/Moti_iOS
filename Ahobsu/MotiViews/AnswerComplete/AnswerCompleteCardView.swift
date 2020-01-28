//
//  AnswerCompleteCardView.swift
//  Ahobsu
//
//  Created by admin on 2019/12/21.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerCompleteCardView: View {
    
    @State var answerCompleteModel: AnswerCompleteModel
    
    var contentView: some View {
        switch answerCompleteModel.answerCompleteType {
        case .essay:
            return AnyView(AnswerComplete_Essay(text: answerCompleteModel.answer))
        case .camera:
            return AnyView(AnswerComplete_Camera(imageURL: answerCompleteModel.imageURL))
        case .essayCamera:
            return AnyView(AnswerComplete_EssayCamera(text: answerCompleteModel.answer,
                                                      imageURL: answerCompleteModel.imageURL))
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(answerCompleteModel.question)
                            .font(.custom("Baskerville", size: 24.0))
                            .foregroundColor(Color(UIColor.rosegold))
                            .lineSpacing(12.0)
                        Spacer()
                        Button(action: update) {
                            Image("icRewriteNormal")
                                .renderingMode(.original)
                                .frame(width: 48.0, height: 48.0)
                        }
                    }
                    .padding([.leading], 20.0)
                    .padding([.trailing], 4.0)
                    VStack {
                        contentView
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 480.0, maxHeight: 480.0)
                    }
                    .padding([.leading, .trailing], 32.0)
                    .padding([.top], 56.0)
                }
            }
        }
    }
    
    func update() {
        
    }
}

struct AnswerCompleteCardView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerCompleteCardView(
            answerCompleteModel: AnswerCompleteModel(answerId: 0,
                                                     question: "Test",
                                                     answer: "Answer",
                                                     answerCompleteType: .essay,
                                                     imageURL: "",
                                                     date: "2019. Nov. 21")
        )
    }
}
