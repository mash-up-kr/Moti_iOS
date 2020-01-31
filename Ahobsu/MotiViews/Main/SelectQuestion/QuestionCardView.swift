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
    var missionData: MissionData

    var body: some View {
        ZStack {
            MainCardView(isWithLine: false)
            VStack {
                HStack {
                    Spacer()
                    if missionData.isImage == true {
                        Image("icCameraNormal")
                    }
                    if missionData.isContent == true {
                        Image("icTextformNormal")
                    } else {
                        
                    }
                    
                }
                .padding([.trailing], 16)

                Spacer()

                HStack {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("질문 \(id)")
                            .font(.system(size: 16,
                                          weight: .bold,
                                          design: .default)
                        )
                            .foregroundColor(Color(.rosegold))

                        Text(missionData.title)
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
                if missionData.isContent == true {
                    if missionData.isImage == true {
                        NavigationLink(destination: AnswerCameraView(missonData: missionData)) {
                            MainButton(title: "답변하기")
                        }.environment(\.isEnabled, !missionData.title.isEmpty)
                    } else {
                        NavigationLink(destination: AnswerInsertEssayView(missonData: missionData)) {
                            MainButton(title: "답변하기")
                        }.environment(\.isEnabled, !missionData.title.isEmpty)
                    }
                } else if missionData.isImage == true {
                    NavigationLink(destination: AnswerCameraView(missonData: missionData)) {
                        MainButton(title: "답변하기")
                    }.environment(\.isEnabled, !missionData.title.isEmpty)
                }
            }
            .padding([.vertical], 20)
        }
        .aspectRatio(0.62, contentMode: .fit)
    }

//    var destinationView: some View {
//        if missionData.isContent == 1 {
//            if missionData.isImage == 1 {
//                return AnswerInsertCameraView(missonData: missionData)
//            } else {
//                return AnswerInsertEssayView(missonData: missionData)
//            }
//        } else if missionData.isImage == 1 {
//            return AnswerInsertCameraView(missonData: missionData)
//        }
//        return AnswerInsertEssayView(missonData: missionData)
//    }
}

//struct QuestionCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionCardView(id: 0)
//    }
//}
