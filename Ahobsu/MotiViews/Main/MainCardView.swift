//
//  MainCardView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/12/18.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct MainCardView: View {
    @State var isWithLine: Bool = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 11)
                .foregroundColor(.black)
                .overlay(RoundedRectangle(cornerRadius: 11)
                    .stroke(Color(.lightgold), lineWidth: 1))
                .shadow(color: Color(.shadowpink), radius: 10, x: 0, y: 0)
                .overlay(
                    ZStack {
                        if isWithLine {

                            RoundedRectangle(cornerRadius: 11)
                                .overlay(RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color(.lightgold), lineWidth: 1)
                                    .foregroundColor(.clear))
                                .padding([.vertical], 13)
                                .padding([.horizontal], 10)

                                .overlay(
                                    RoundedRectangle(cornerRadius: 11)
                                        .overlay(RoundedRectangle(cornerRadius: 11)
                                            .stroke(Color(.lightgold), lineWidth: 1))
                                        .foregroundColor(.clear)
                                        .padding([.vertical], 10)
                                        .padding([.horizontal], 13))

                        }
                    }
            )
                .foregroundColor(.clear)
        }
    }
}

struct MainCardView_Previews: PreviewProvider {
    static var previews: some View {
        MainCardView(isWithLine: true)
            .padding(60)
    }
}
