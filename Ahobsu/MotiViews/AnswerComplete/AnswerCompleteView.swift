//
//  AnswerComplete.swift
//  Ahobsu
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Combine
import SwiftUI

enum AnswerMode {
    case essay
    case camera
    case essayCamera
}

struct AnswerCompleteView: View {

    var answerMode: AnswerMode

    var contentView: some View {
        switch answerMode {
        case .essay:
            return AnyView(AnswerComplete_Essay())
        case .camera:
            return AnyView(AnswerComplete_Camera())
        case .essayCamera:
            return AnyView(AnswerComplete_EssayCamera())
        }
    }

    var body: some View {
        ZStack {
            contentView
            AnyView(Navigation())
        }
    }
}

struct Navigation: View {

    var buttonWidth: CGFloat { 44.0 }
    var buttonHeight: CGFloat { 44.0 }

    var backButton: some View {
        Button(action: {
            print("Tapped")
        }, label: {
            Text("<")
        }).frame(width: buttonWidth, height: buttonHeight, alignment: .center)
    }

    var body: some View {
        VStack {
            HStack {
                backButton
                Spacer()
            }
            Spacer()
        }
    }
}

struct AnswerCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AnswerCompleteView(answerMode: .essay)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max - Essay")

            AnswerCompleteView(answerMode: .camera)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max - Camera")

            AnswerCompleteView(answerMode: .essayCamera)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max - EssayCamera")
        }
    }
}
