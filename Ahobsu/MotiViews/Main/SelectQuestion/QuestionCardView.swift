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
    @State var missionData: MissionData = MissionData(id: 1, title: "", isContent: 1, isImage: 1)

    var body: some View {
        ZStack {
            MainCardView(isWithLine: false)
            VStack {
                HStack {
                    Spacer()
                    if missionData.isImage == 1 {
                        Image("icCameraNormal")
                    }
                    if missionData.isContent == 1 {
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
                if missionData.isContent == 1 {
                    if missionData.isImage == 1 {
                        NavigationLink(destination: AnswerInsertCameraView(missonData: missionData)) {
                            MainButton(title: "답변하기").environment(\.isEnabled, true)
                        }
                    } else {
                        NavigationLink(destination: AnswerInsertEssayView(missonData: missionData)) {
                            MainButton(title: "답변하기").environment(\.isEnabled, true)
                        }
                    }
                } else if missionData.isImage == 1 {
                    NavigationLink(destination: AnswerInsertCameraView(missonData: missionData)) {
                        MainButton(title: "답변하기").environment(\.isEnabled, true)
                    }
                }
            }
            .padding([.vertical], 20)
        }
        .aspectRatio(0.62, contentMode: .fit)
    }

    var destinationView: some View {
        if missionData.isContent == 1 {
            if missionData.isImage == 1 {
                return AnswerInsertCameraView(missonData: missionData)
            } else {
                return AnswerInsertEssayView(missonData: missionData)
            }
        } else if missionData.isImage == 1 {
            return AnswerInsertCameraView(missonData: missionData)
        }
        return AnswerInsertEssayView(missonData: missionData)
    }
}

//struct QuestionCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionCardView(id: 0)
//    }
//}
