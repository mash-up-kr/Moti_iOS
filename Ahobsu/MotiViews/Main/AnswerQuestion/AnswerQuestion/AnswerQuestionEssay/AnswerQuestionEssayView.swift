//
//  AnswerQuestionEssayView.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/03/13.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerQuestionEssayView: View {
    @State var text = ""
    
    var body: some View {
        NavigationMaskingView(titleItem: Text("답변하기")
                                .font(.system(size: 16)),
                              trailingItem: Button(action: {}, label: {
                                Text("완료")
                                    .foregroundColor(Color(.rosegold))
                                    .font(.system(size: 16))
                              })
        ) {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    Text("질문에 답변을\n해주세요.")
                        .foregroundColor(Color(.rosegold))
                        .font(.custom("IropkeBatangOTFM", size: 20))
                        .lineSpacing(10.0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.all, 20)
                    
                    Image("imgAnswerdecoBar1")
                        .frame(width: .infinity, height: 75, alignment: .center)
                    
                    ZStack {
                        TextView(text: $text)
                        VStack {
                            Text("이곳에 질문에 대한 답변을 적어주세요.")
                                .foregroundColor(Color(.placeholderblack))
                                .font(.custom("IropkeBatangOTFM", size: 16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 32, trailing: 20))
                }
            }
        }
    }
}

struct AnswerQuestionEssayView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerQuestionEssayView()
    }
}
