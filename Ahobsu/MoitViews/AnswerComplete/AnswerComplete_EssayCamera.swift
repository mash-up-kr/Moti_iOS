//
//  AnswerComplete_EssayCamera.swift
//  Ahobsu
//
//  Created by admin on 2019/11/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerComplete_EssayCamera: View {

    var cameraViewSpacing: CGFloat { 0.0 }

    var sampleImageURL: String {
        "https://cdn.pixabay.com/photo/2018/09/02/14/42/river-3648947_1280.jpg"
    }

    var questionViewText: String {
        "오늘의 먹은 음식을\n사진으로 남겨보세요.\n세줄짜리"
    }

    var questionViewColor: Color { Color.white }

    var questionPaddingLeading: CGFloat { 15.0 }
    var questionPaddingBottom: CGFloat { 15.0 }

    var questionMaxHeight: CGFloat { 375.0 }

    var answerViewText: String { "오늘 비가 와요.\n비를 주제로 사진과 함께\n한 줄 시를 써볼까요?" }

    var answerPaddingTop: CGFloat { 20.0 }
    var answerBackgroundColor: Color {
        Color.init(red: 216/255, green: 216/255, blue: 216/255)
    }

    var body: some View {
        VStack(spacing: cameraViewSpacing) {
            ZStack {
                ImageView(withURL: sampleImageURL)
                    .overlay(
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, .black]),
                                    startPoint: .center,
                                    endPoint: .bottom)
                        )
                            .clipped()
                )
                VStack {
                    Spacer()
                    HStack {
                        QuestionView(text: questionViewText)
                            .foregroundColor(questionViewColor)
                        Spacer()
                    }.padding(.leading, questionPaddingLeading)
                        .padding(.bottom, questionPaddingBottom)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: questionMaxHeight)
            VStack {
                AnswerView(text: answerViewText)
                    .multilineTextAlignment(.center)
                Spacer()
            }.padding(.top, answerPaddingTop)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(answerBackgroundColor)
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
    }
}

struct AnswerComplete_EssayCamera_Previews: PreviewProvider {
    static var previews: some View {
        AnswerComplete_EssayCamera()
    }
}
