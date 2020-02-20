//
//  AnswerComplete_EssayCamera.swift
//  Ahobsu
//
//  Created by 김선재 on 2019/11/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//
import SwiftUI

struct AnswerComplete_EssayCamera: View {
    
    @State var text: String
    @State var imageURL: String
    
    var body: some View {
        ZStack {
            MainCardView(isWithLine: true)
            VStack {
                VStack {
                    ImageView(withURL: imageURL)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 255.0)
                        .cornerRadius(6.0)
                        .padding([.bottom], 20.0)
                    Text(text)
                        .multilineTextAlignment(.center)
                        .font(.custom("IropkeBatangM", size: 16.0))
                        .foregroundColor(Color(UIColor.rosegold))
                        .lineSpacing(8.0)
                    Spacer()
                }
                .padding([.all], 16.0)
            }
            .padding([.all], 12.0)
        }
    }
}
