//
//  AnswerComple_Essay.swift
//  Ahobsu
//
//  Created by 김선재 on 2019/11/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//
import SwiftUI

struct AnswerComplete_Essay: View {
    @State var title: String
    @State var text: String
    
    var body: some View {        
        ZStack {
            VStack(spacing: 0) {
                Text(title)
                    .foregroundColor(Color(.rosegold))
                    .font(.custom("IropkeBatangOTFM", size: 20))
                    .lineSpacing(10.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.all, 20)
                
                Image("imgAnswerdecoBar1")
                    .frame(height: 75)
                    .frame(maxWidth: .infinity)
                
                ZStack {
                    TextView(text: $text, isEditable: false)
//                        .disabled(true)
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 32, trailing: 20))
                Spacer()
            }
        }
    }
}
