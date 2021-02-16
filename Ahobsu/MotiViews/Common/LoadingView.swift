//
//  LoadingView.swift
//  Ahobsu
//
//  Created by 김선재 on 05/03/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct LoadingView: View {

    var isShowing: Bool

    var body: some View {
        VStack {
            Text("불러오는 중...")
            ActivityIndicator(isAnimating: .constant(true), style: .large)
        }
        .padding(28)
        .background(Color.secondary.colorInvert())
        .foregroundColor(Color.primary)
        .cornerRadius(20)
        .opacity(self.isShowing ? 1 : 0)
    }
    
}
