//
//  DisconnectionView.swift
//  Ahobsu
//
//  Created by 김선재 on 17/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct UnknownErrorView: View {
    
    var imageName: String { "icErrorInternet" }
    var imagePaddingBottom: CGFloat { 16.0 }
    
    var sublineFont: Font { Font.custom("IropkeBatangOTFM", size: 14.0) }
    var sublineLineSpacing: CGFloat { 26.0 }
    var sublinePaddingBottom: CGFloat { 32.0 }
    
    var buttonAction: () -> Void
    
    init(retryAction: @escaping () -> Void) {
        self.buttonAction = retryAction
    }
    
    var body: some View {
        VStack {
            Image(imageName)
                .padding(.bottom, imagePaddingBottom)
            Text("알 수 없는 오류가 발생했습니다.")
                .lineLimit(nil)
                .font(sublineFont)
                .lineSpacing(sublineLineSpacing)
                .padding(.bottom, sublinePaddingBottom)
            MainButton(action: buttonAction, title: "재접속")
        }
    }
}
