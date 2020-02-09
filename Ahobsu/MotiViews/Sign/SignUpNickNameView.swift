//
//  SignUpNickNameView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI
import Combine

struct SignUpNickNameView: View {
    
    @State var buttonEnabled: Bool = false
    
    @Binding var window: UIWindow
    
    @ObservedObject var keyboard: Keyboard = Keyboard()
    @ObservedObject var signUp = SignUp()
    
    @State var pushNextView: Bool = false
    
    var body: some View {
        
        let contentView = VStack {
            TextField("",
                      text: $signUp.nickname,
                      onEditingChanged: { (onEditing) in
                        if onEditing == false {
                            UserDefaults.standard.setValue(self.signUp.nickname, forKey: "SignUp.Nickname")
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
        return NavigationMaskingView(titleItem: Text("닉네임 설정"), trailingItem: EmptyView()) {
            SignUpFormView(title: "닉네임을 입력해주세요.",
                           content: contentView,
                           buttonTitle: "다 음",
                           buttonDestination: SignUpGenderView(window: $window, signUp: signUp),
                           buttonAction: {
                            self.pushNextView = true
            },
                           buttonEnabled: buttonEnabled,
                           pushDestination: $pushNextView)
                .padding([.bottom], keyboard.state.height)
                .edgesIgnoringSafeArea((keyboard.state.height > 0) ? [.bottom] : [])
                .animation(.easeOut(duration: keyboard.state.animationDuration))
                .onTapGesture {
                    self.window.endEditing(true)
            }.onReceive(signUp.validatedNickname) {
                self.buttonEnabled = $0 != nil
            }
        }
    }
}

struct SignUpNameView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Empty Nickname
            SignUpNickNameView(window: .constant(UIWindow()))
            
            // Invalid Nickname
            SignUpNickNameView(window: .constant(UIWindow()))
            
            // Valid Nickname
            SignUpNickNameView(window: .constant(UIWindow()))
        }
    }
}
