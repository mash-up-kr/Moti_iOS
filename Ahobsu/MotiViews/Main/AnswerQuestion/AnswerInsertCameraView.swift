//
//  AnswerInsertCameraView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/12/21.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerInsertCameraView: View {
    var body: some View {
        ZStack {
            BackgroundView()
                .edgesIgnoringSafeArea([.vertical])
            VStack {
                HStack {
                    Text("오늘 먹은 음식을 \n사진으로 남겨볼까요?")
                        .font(.system(size: 24))
                        .lineSpacing(6)
                        .foregroundColor(Color(.rosegold))
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
                Image("imgCam")
                Spacer()
                MainButton(title: "제출하기")
                Spacer()
            }
            .padding([.horizontal], 20)
        }
    }
}

struct AnswerInsertCameraView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerInsertCameraView()
    }
}
