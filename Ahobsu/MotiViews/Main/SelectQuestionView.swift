//
//  SelectQuestionView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SelectQuestionView: View {
    @Binding var isNavigationBarHidden: Bool

    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea([.vertical])
            HStack {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 24) {
                            QuestionCardView()
                            QuestionCardView()
//                                .opacity(0.5)
                            QuestionCardView()
                        }
                        .padding([.vertical], 10)
                        .padding([.horizontal], 60)
                    }
                    .frame(height: 450, alignment: .center)
                }
            }


        }
    }
}

struct SelectQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectQuestionView(isNavigationBarHidden: .constant(true))
    }
}
