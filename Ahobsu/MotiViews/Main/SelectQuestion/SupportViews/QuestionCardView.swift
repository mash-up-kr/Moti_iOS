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
    var missionData: Mission
    @Binding var isStatusBarHidden: Bool
    
    var body: some View {
        ZStack {
            CardView(innerLine: false)
            VStack {
                HStack {
                    Spacer()
                    if missionData.isImage == true {
                        Image("icCameraNormal")
                    }
                    if missionData.isContent == true {
                        Image("icTextformNormal")
                    }
                }
                .padding([.trailing], 16)
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("질문 \(id + 1)")
                            .font(.custom("AppleSDGothicNeo-Bold", size: 16.0))
                            .foregroundColor(Color(.rosegold))
                        
                        Text(missionData.title)
                            .font(.custom("IropkeBatangOTFM", size: 22.0))
                            .foregroundColor(Color(.rosegold))
                            .lineSpacing(10)
                    }
                    Spacer()
                }
                .padding([.horizontal], 16)
                Spacer()
                if missionData.isContent == true {
                    if missionData.isImage == true {
                        NavigationLink(destination: AnswerQuestionImageEssayView(missionData: missionData)) {
                            MainButton(title: "답변하기")
                        }.environment(\.isEnabled, !missionData.title.isEmpty)
                    } else {
                        NavigationLink(destination: AnswerQuestionEssayView(missionData: missionData)) {
                            MainButton(title: "답변하기")
                        }.environment(\.isEnabled, !missionData.title.isEmpty)
                    }
                } else if missionData.isImage == true {
                    NavigationLink(destination: AnswerQuestionImageView(missionData: missionData)) {
                        MainButton(title: "답변하기")
                    }.environment(\.isEnabled, !missionData.title.isEmpty)
                }
            }
            .padding([.vertical], 20)
        }
        .aspectRatio(0.62, contentMode: .fit)
    }
}

//struct QuestionCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionCardView(id: 0)
//    }
//}
