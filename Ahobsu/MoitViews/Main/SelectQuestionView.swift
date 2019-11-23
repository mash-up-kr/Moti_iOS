//
//  SelectQuestionView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SelectQuestionView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("오늘의 질문을 \n선택해주세요.")
                .font(
                    .system(size: 28,
                            weight: .regular,
                            design: .default))
                .lineSpacing(6)
            Spacer(minLength: 24)
            Circle()
                .frame(minWidth: 0, maxWidth: 300, minHeight: 0, maxHeight: 300, alignment: .center)
                .offset(x: -140, y: 0)
            Spacer(minLength: 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {

                    QuestionCellView()
                    QuestionCellView()
                    QuestionCellView()
                    QuestionCellView()
                    QuestionCellView()
                    QuestionCellView()
                }
            }
            .frame(height: 160)
            .padding(EdgeInsets(top: 0, leading: 3, bottom: 32, trailing: 0))
        }
    }
}

struct SelectQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectQuestionView()
    }
}
