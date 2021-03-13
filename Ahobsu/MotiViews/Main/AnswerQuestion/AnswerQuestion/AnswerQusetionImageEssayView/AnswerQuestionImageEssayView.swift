//
//  AnswerQuestionImageEssayView.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/03/13.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerQuestionImageEssayView: View {
    @State var text = ""
    
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
                    .frame(width: .infinity, height: 200, alignment: .center)
                    
                    Color(.goldbrown)
                        .frame(width: .infinity, height: 1)
                    Text("질문에 답변을\n해주세요.")
                        .foregroundColor(Color(.rosegold))
                        .font(.custom("IropkeBatangOTFM", size: 20))
                        .lineSpacing(10.0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.all, 20)
                    
                    Image("")
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

struct AnswerQuestionImageEssayView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerQuestionImageEssayView()
    }
}
