//
//  AnswerComplete_Camera.swift
//  Ahobsu
//
//  Created by admin on 2019/11/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerComplete_Camera: View {

    var cameraViewSpacing: CGFloat { 60.0 }

    var questionViewText: String {
        "오늘의 먹은 음식을\n사진으로 남겨보세요.\n세줄짜리"
    }

    var questionPaddingTop: CGFloat { 80.0 }
    var questionPaddingLeading: CGFloat { 15.0 }
    var questionPaddingTrailing: CGFloat { 15.0 }

    var sampleImageURL: String {
        "https://cdn.pixabay.com/photo/2018/09/02/14/42/river-3648947_1280.jpg"
    }

    var body: some View {
        VStack(spacing: cameraViewSpacing) {
            VStack {
                HStack {
                    QuestionView(text: questionViewText)
                    Spacer()
                }
            }.padding(.top, questionPaddingTop)
                .padding(.leading, questionPaddingLeading)
                .padding(.trailing, questionPaddingTrailing)
            ImageView(withURL: sampleImageURL)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
    }
}
struct AnswerComplete_Camera_Previews: PreviewProvider {
    static var previews: some View {
        AnswerComplete_Camera()
    }
}
