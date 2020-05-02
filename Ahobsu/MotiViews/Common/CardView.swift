//
//  MainCardView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/12/18.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var isWithLine: Bool = false
    var cornerRadius: CGFloat = 11.0
    var shadowRadius: CGFloat = 10.0
    var innerPaddingTop: CGFloat = 10.0
    var innerPaddingLeading: CGFloat = 10.0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(.black)
                .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color(.lightgold), lineWidth: 1))
                .shadow(color: Color(.shadowpink), radius: shadowRadius / 2, x: 0, y: 0)
                .overlay(
                    ZStack {
                        if isWithLine {
                            
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                                    .stroke(Color(.lightgold), lineWidth: 1)
                                    .foregroundColor(.clear))
                                .padding([.vertical], 17)
                                .padding([.horizontal], 12)
                                
                                .overlay(
                                    RoundedRectangle(cornerRadius: 11)
                                        .overlay(RoundedRectangle(cornerRadius: 11)
                                            .stroke(Color(.lightgold), lineWidth: 1))
                                        .foregroundColor(.clear)
                                        .padding([.vertical], 12)
                                        .padding([.horizontal], 17))
                        }
                    }
            )
                .foregroundColor(.clear)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(isWithLine: true)
            .padding(60)
    }
}
