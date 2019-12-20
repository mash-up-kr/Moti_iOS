//
//  SignUpNickNameView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SignUpNickNameView: View {

    @Binding var window: UIWindow
    @State var nickName: String = ""
    @ObservedObject var keyboard: Keyboard = Keyboard()

    var body: some View {
        let contentView = TextField("",
                  text: $nickName,
                  onEditingChanged: { (_) in
                    // Next Step
        },
                  onCommit: {
                    // Next Step
        }).background(Divider().foregroundColor(Color.black),
                      alignment: .bottom)
            .padding(.horizontal, 66)
        return SignUpFormView(title: "닉네임을 입력해주세요.",
                              content: contentView,
                              buttonTitle: "다 음",
            buttonDestination: SignUpGenderView(window: $window))
            .padding([.bottom], keyboard.state.height)
            .edgesIgnoringSafeArea((keyboard.state.height > 0) ? [.bottom] : [])
            .animation(.easeOut(duration: keyboard.state.animationDuration))
    }
}

struct SignUpNameView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNickNameView(window: .constant(UIWindow()))
    }
}
