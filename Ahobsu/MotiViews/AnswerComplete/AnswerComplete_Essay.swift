//
//  AnswerComple_Essay.swift
//  Ahobsu
//
//  Created by admin on 2019/11/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerComplete_Essay: View {

    @State var text: String = """
    이런들 어떠하리 저런들 어떠하리
    만수산 드렁칡이 얽혀진들 어떠하리
    우리도 이같이 얽혀져
    백년까지 누리리라

    이 몸이 죽고 죽어 일백 번 고쳐죽어
    백골이 진토 되어 넋이라도 있고 없고
    임 향한 일편단심이야 가실 줄이 있으랴
    """

    var body: some View {
        ZStack {
            MainCardView(isWithLine: true)
            VStack {
                Text(text)
                    .multilineTextAlignment(.center)
                    .font(.custom("Baskerville", size: 16.0))
                    .foregroundColor(Color(UIColor.rosegold))
                    .lineSpacing(8.0)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .padding([.all], 16.0)
        }
    }
}

struct AnswerComplete_Essay_Previews: PreviewProvider {
    static var previews: some View {
        AnswerComplete_Essay()
    }
}
