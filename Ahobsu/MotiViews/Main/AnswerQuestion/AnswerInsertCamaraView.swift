//
//  AnswerInsertCamaraView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2020/01/29.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerInsertCamaraView: View {
    @Binding var image: UIImage?
    
    var body: some View {
        ZStack {
            BackgroundView()
                .edgesIgnoringSafeArea([.vertical])
            ZStack {
                VStack(spacing: 20) {
                    Spacer()
                    ZStack {
                        MainCardView(isWithLine: true)
                            .aspectRatio(0.62, contentMode: .fit)
                            .padding(.horizontal, 12)
                            .overlay(
                                Image(uiImage: image ?? UIImage())
                                    .resizable()
                                    .cornerRadius(6)
                                    .padding(.horizontal, 34)
                                    .padding(.vertical, 22)
                        )
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    MainButton(title: "제출하기")
                    Spacer().frame(height: 32)
                    
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct AnswerInsertCamaraView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerInsertCamaraView(image: .constant(UIImage()))
    }
}
