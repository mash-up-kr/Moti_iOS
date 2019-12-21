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
    var buttonEnabled: Bool {
        return self.nickName.count == 8
    }

    var body: some View {

        let contentView = VStack {
            TextField("",
                      text: $nickName,
                      onEditingChanged: { (onEditing) in
                        if onEditing == false {
                            UserDefaults.standard.setValue(self.nickName, forKey: "SignUp.Nickname")
                        }
            },
                      onCommit: {
                        // Next Step
            }).background(Divider().foregroundColor(Color.black),
                          alignment: .bottom)
                .padding(.horizontal, 66)
                .foregroundColor(Color(.rosegold))
                .multilineTextAlignment(.center)
            Text("8글자로 만들어주세요.")
                .foregroundColor(Color(white: 121/255))
                .font(.system(size: 14))
        }
        return SignUpFormView(title: "닉네임을 입력해주세요.",
                              content: contentView,
                              buttonTitle: "다 음",
                              buttonDestination: SignUpGenderView(window: $window),
                              buttonEnabled: buttonEnabled)
            .padding([.bottom], keyboard.state.height)
            .edgesIgnoringSafeArea((keyboard.state.height > 0) ? [.bottom] : [])
            .animation(.easeOut(duration: keyboard.state.animationDuration))
    }
}

struct SignUpNameView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Empty Nickname
            SignUpNickNameView(window: .constant(UIWindow()))

            // Invalid Nickname
            SignUpNickNameView(window: .constant(UIWindow()), nickName: "8글자가안되는")

            // Valid Nickname
            SignUpNickNameView(window: .constant(UIWindow()), nickName: "아무거나입력한것")
        }
    }
}
