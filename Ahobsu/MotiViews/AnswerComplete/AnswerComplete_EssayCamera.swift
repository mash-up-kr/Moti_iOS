//
//  AnswerComplete_EssayCamera.swift
//  Ahobsu
//
//  Created by 김선재 on 2019/11/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//
import SwiftUI

struct AnswerComplete_EssayCamera: View {
    @State var title: String
    @State var text: String
    @State var imageURL: String
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack {
                    ImageView(withURL: imageURL)
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                        .allowsHitTesting(false)
                        .clipped()
                }
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .clipped()
                Color(.goldbrown)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
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
                        .frame(minHeight: 200)
//                        .disabled(true)
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 32, trailing: 20))
            }
        }
    }
}
