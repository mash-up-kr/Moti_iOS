//
//  QuestionCellView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct QuestionCellView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("질문 1")
                    .font(
                        .system(size: 16,
                                weight: .bold,
                                design: .default)
                )
                Spacer()
                Text("글 & 사진")
                    .font(
                        .system(size: 14,
                                weight: .regular,
                                design: .default)
                )

            }
            Spacer()
            Text("오늘 비가와요. \n비를 주제로 사진과 함께 \n한줄 시를 써볼까요?")
                .font(
                    .system(size: 22,
                            weight: .regular,
                            design: .default)
            )
        }
        .padding(EdgeInsets(top: 20,
                            leading: 16,
                            bottom: 24,
                            trailing: 16))
            .background(Color.blue)
            .cornerRadius(11)
            .padding([.leading], 12)
    }
}

struct QuestionCellView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionCellView()
            .previewLayout(.fixed(width: 300, height: 200))
    }
}
