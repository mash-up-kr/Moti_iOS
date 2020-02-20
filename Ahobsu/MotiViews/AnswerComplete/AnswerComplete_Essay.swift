//
//  AnswerComple_Essay.swift
//  Ahobsu
//
//  Created by 김선재 on 2019/11/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//
import SwiftUI

struct AnswerComplete_Essay: View {
    
    @State var text: String
    
    var body: some View {
        ZStack {
            MainCardView(isWithLine: true)
            VStack {
                Text(text)
                    .multilineTextAlignment(.center)
                    .font(.custom("IropkeBatangM", size: 16.0))
                    .foregroundColor(Color(UIColor.rosegold))
                    .lineSpacing(8.0)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .padding([.all], 16.0)
        }
    }
}
