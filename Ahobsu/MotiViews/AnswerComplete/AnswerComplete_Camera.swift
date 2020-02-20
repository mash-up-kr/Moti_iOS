//
//  AnswerComplete_Camera.swift
//  Ahobsu
//
//  Created by 김선재 on 2019/11/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerComplete_Camera: View {
    
    @State var imageURL: String
    
    var body: some View {
        ZStack {
            MainCardView(isWithLine: true)
            VStack {
                ImageView(withURL: imageURL)
                    .scaledToFit()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 424.0)
                    .cornerRadius(6.0)
                    .padding([.all], 28.0)
            }
        }
    }
}
