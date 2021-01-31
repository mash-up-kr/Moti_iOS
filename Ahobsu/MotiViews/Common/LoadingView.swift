//
//  LoadingView.swift
//  Ahobsu
//
//  Created by 김선재 on 05/03/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    
    var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                
                VStack {
                    Text("불러오는 중...")
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }.frame(width: geometry.size.width / 2,
                        height: geometry.size.height / 5)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                    .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
    
}
