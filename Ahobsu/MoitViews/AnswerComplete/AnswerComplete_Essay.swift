//
//  AnswerComple_Essay.swift
//  Ahobsu
//
//  Created by admin on 2019/11/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerComplete_Essay: View {

<<<<<<< HEAD
    var questionVStackSpacing: CGFloat { 16.0 }

    var questionHStackSpacing: CGFloat { 10.0 }

=======
>>>>>>> fix: 답변 완료 개별 화면 파일 구조 분리
    var questionViewText: String {
        "오늘 비가와요.\n비를 주제로\n한줄 시를 써볼까요?"
    }

<<<<<<< HEAD
    var questionViewShuffleWidth: CGFloat { 44.0 }
    var questionViewShuffleHeight: CGFloat { 44.0 }

=======
>>>>>>> fix: 답변 완료 개별 화면 파일 구조 분리
    var circleWidth: CGFloat { 268.0 }
    var circleHeight: CGFloat { 268.0 }

    var questionPaddingTop: CGFloat { 80.0 }
    var questionPaddingLeading: CGFloat { 15.0 }
    var questionPaddingTrailing: CGFloat { 15.0 }

    var answerViewText: String { "종로3가 순두부 식당 맛있어보인다.\n갈지 말지 고민됨\n밖은 너무 추워보임..." }

    var answerPaddingTop: CGFloat { 20.0 }
    var answerMaxHeight: CGFloat { 272.0 }
<<<<<<< HEAD

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
=======
    var answerBackgroundColor: Color {
        Color.init(red: 216/255, green: 216/255, blue: 216/255)
    }

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                HStack {
                    QuestionView(text: questionViewText)
                    Spacer()
>>>>>>> fix: 답변 완료 개별 화면 파일 구조 분리
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
<<<<<<< HEAD
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: answerMaxHeight)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.38), radius: 10, x: 0, y: 4)
=======
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: answerMaxHeight)
                    .background(answerBackgroundColor)
>>>>>>> fix: 답변 완료 개별 화면 파일 구조 분리
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
