//
//  AnswerComple_Essay.swift
//  Ahobsu
//
//  Created by admin on 2019/11/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerComplete_Essay: View {

    var questionVStackSpacing: CGFloat { 16.0 }
    
    var questionHStackSpacing: CGFloat { 10.0 }
    
    var questionViewText: String {
        "오늘 비가와요.\n비를 주제로\n한줄 시를 써볼까요?"
    }
    
    var questionViewShuffleWidth: CGFloat { 44.0 }
    var questionViewShuffleHeight: CGFloat { 44.0 }

    var circleWidth: CGFloat { 268.0 }
    var circleHeight: CGFloat { 268.0 }

    var questionPaddingTop: CGFloat { 80.0 }
    var questionPaddingLeading: CGFloat { 15.0 }
    var questionPaddingTrailing: CGFloat { 15.0 }

    var answerViewText: String { "종로3가 순두부 식당 맛있어보인다.\n갈지 말지 고민됨\n밖은 너무 추워보임..." }

    var answerPaddingTop: CGFloat { 20.0 }
    var answerMaxHeight: CGFloat { 272.0 }

    var body: some View {
        ZStack {
            VStack(spacing: questionVStackSpacing) {
                HStack(alignment: .top, spacing: questionHStackSpacing) {
                    QuestionView(text: questionViewText)
                    Spacer()
                    Button(action: {
                        // TODO: To add shuffle func
                        print("Tapped")
                    }, label: {
                        // TODO: To change button image
                        Image(systemName: "shuffle")
                    }).frame(width: questionViewShuffleWidth,
                             height: questionViewShuffleHeight)
                }
                Circle()
                    .fill(Color.gray)
                    .frame(width: circleWidth,
                           height: circleHeight)
                Spacer()
            }.padding(.top, questionPaddingTop)
                .padding(.leading, questionPaddingLeading)
                .padding(.trailing, questionPaddingTrailing)

            VStack {
                Spacer()
                VStack {
                    AnswerView(text: answerViewText)
                    Spacer()
                }.padding(.top, answerPaddingTop)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: answerMaxHeight)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.38), radius: 10, x: 0, y: 4)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
    }
}

struct AnswerComplete_Essay_Previews: PreviewProvider {
    static var previews: some View {
        AnswerComplete_Essay()
    }
}
