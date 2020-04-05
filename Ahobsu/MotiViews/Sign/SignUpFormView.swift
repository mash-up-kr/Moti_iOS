//
//  SignUpFormView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SignUpFormView<Content, Destination>: View where Content: View, Destination: View {
    
    var title: String
    var content: Content
    var buttonTitle: String
    var buttonDestination: Destination
    var buttonAction: (() -> Void)?
    var buttonEnabled: Bool
    @Binding var pushDestination: Bool
    var canSkip: Bool = false
    var skipAction: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text(title)
                    .font(.system(size: 28))
                    .foregroundColor(Color(.rosegold))
                    .padding(.horizontal, 15)
                    .multilineTextAlignment(.center)
                Spacer()
                content
                Spacer()
                // Next Step
                NavigationLink(destination: buttonDestination, isActive: $pushDestination) {
                    MainButton(action: buttonAction, title: buttonTitle)
                }.environment(\.isEnabled, buttonEnabled)
                Spacer()
                if canSkip {
                    Button(action: {
                        self.skipAction?()
                    }) {
                        Text("건너뛰기").foregroundColor(Color(.rosegold))
                    }
                    Spacer()
                }
            }.frame(maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.vertical)
        .frame(maxWidth: .infinity)
        .background(BackgroundView().edgesIgnoringSafeArea(.vertical))
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpFormView(title: "타이틀을 입력해주세요.",
                       content: Text("Content View"),
                       buttonTitle: "다 음",
                       buttonDestination: Text("Next View"),
                       buttonAction: nil,
                       buttonEnabled: false,
                       pushDestination: .constant(false))
    }
}
