//
//  QuestionCardView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/12/19.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct QuestionCardView: View, Identifiable {
    var id: Int

    var body: some View {
        ZStack {
            MainCardView(isWithLine: false)
            VStack {
                HStack {
                    Spacer()
                    Image("icCameraNormal")
                    Image("icTextformNormal")
                }
                .padding([.trailing], 16)

                Spacer()

                HStack {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("질문 1")
                            .font(.system(size: 16,
                                          weight: .bold,
                                          design: .default)
                        )
                            .foregroundColor(Color(.rosegold))

                        Text("오늘 비가와요.\n비를 주제로 사진과 함께\n한줄 시를 써볼까요?")
                            .font(.system(size: 22,
                                          weight: .regular,
                                          design: .default)
                        )
                            .foregroundColor(Color(.rosegold))
                            .lineSpacing(10)
                    }
                    Spacer()
                }
                .padding([.horizontal], 16)
                Spacer()
                NavigationLink(destination: AnswerInsertEssayView()) {
                    MainButton(title: "답변하기").environment(\.isEnabled, true)
                }
            }
            .padding([.vertical], 20)
        }
        .aspectRatio(0.62, contentMode: .fit)
    }
}

struct QuestionCardView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCardView(id: 0)
    }
}
