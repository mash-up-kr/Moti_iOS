//
//  AnswerQuestionImageView.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/03/13.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerQuestionImageView: View {
    var body: some View {
        NavigationMaskingView(titleItem: Text("답변하기"),
                              trailingItem: Text("완료")) {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    ZStack {
                        Image("icEmpty")
                        Image("")
                            .resizable()
                    }
                    Color(.goldbrown)
                        .frame(width: .infinity, height: 1)
                    Text("질문에 답변을\n해주세요.")
                        .foregroundColor(Color(.rosegold))
                        .font(.custom("IropkeBatangOTFM", size: 20))
                        .lineSpacing(10.0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.all, 20)
                }
            }
        }
    }
}

struct AnswerQuestionImageView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerQuestionImageView()
    }
}
