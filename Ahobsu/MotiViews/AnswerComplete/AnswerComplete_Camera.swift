//
//  AnswerComplete_Camera.swift
//  Ahobsu
//
//  Created by 김선재 on 2019/11/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerComplete_Camera: View {
    @State var title: String
    @State var imageURL: String
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                ImageView(withURL: imageURL)
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 4 / 3)
                    .allowsHitTesting(false)
                    .clipped()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 4 / 3)
            .clipped()

            Color(.goldbrown)
                .frame(height: 1)
                .frame(maxWidth: .infinity)
            Text(title)
                .foregroundColor(Color(.rosegold))
                .font(.custom("IropkeBatangOTFM", size: 20))
                .lineSpacing(10.0)
                .frame(height: 500, alignment: .topLeading)
//                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.all, 20)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}
