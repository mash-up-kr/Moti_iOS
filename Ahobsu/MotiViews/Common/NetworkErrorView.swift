//
//  NetworkErrorView.swift
//  Ahobsu
//
//  Created by admin on 17/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct NetworkErrorView: View {

    var imageName: String { "icErrorInternet" }
    var imagePaddingBottom: CGFloat { 16.0 }
    
    var sublineFont: Font { Font.custom("IropkeBatangOTFM", size: 14.0) }
    var sublineLineSpacing: CGFloat { 26.0 }
    
    var buttonAction: () -> Void
    
    init(retryAction: @escaping () -> Void) {
        self.buttonAction = retryAction
    }
    
    var body: some View {
        VStack {
            Image(imageName)
                .padding(.bottom, imagePaddingBottom)
            Text("인터넷이 불안정해요.\n확인 후 재접속 해주세요.")
                .lineLimit(nil)
                .font(sublineFont)
                .lineSpacing(sublineLineSpacing)
            MainButton(action: buttonAction, title: "재접속")
        }
    }
}
