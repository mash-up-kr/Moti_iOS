//
//  SignUpNickNameView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI
import Combine

class NicknameWithLimit: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    
    let characterLimit: Int
    
    init(initText: String = "", limit: Int = 8) {
        text = initText
        characterLimit = limit
    }
    
    init(limit: Int = 8) {
        characterLimit = limit
    }
}

struct SignUpNickNameView: View {
    
    @State var buttonEnabled: Bool = false
    
    @Binding var window: UIWindow
    
    @ObservedObject var keyboard: Keyboard = Keyboard()
    @ObservedObject var signUp = SignUp()
    @ObservedObject var nickname = NicknameWithLimit()
    
    @State var pushNextView: Bool = false
    
    var body: some View {
        
        let contentView = VStack {
            TextField("",
                      text: $nickname.text,
                      onEditingChanged: { (onEditing) in
                        if onEditing == false {
                            UserDefaults.standard.setValue(self.nickname.text, forKey: "SignUp.Nickname")
                        }
            },
                      onCommit: {
                        // Next Step
            }).background(Divider().foregroundColor(Color.black),
                          alignment: .bottom)
                .padding(.horizontal, 66)
                .foregroundColor(Color(.rosegold))
                .multilineTextAlignment(.center)
            Text("8글자이내로 만들어주세요.")
                .foregroundColor(Color(white: 121/255))
                .font(.system(size: 14))
        }
        return NavigationMaskingView(isRoot: true, titleItem: Text("닉네임 설정"), trailingItem: EmptyView()) {
            SignUpFormView(title: "닉네임을 입력해주세요.",
                           content: contentView,
                           buttonTitle: "다 음",
                           buttonDestination: SignUpGenderView(window: $window, signUp: signUp),
                           buttonAction: {
                            self.signUp.nickname = self.nickname.text
                            self.pushNextView = true
            },
                           buttonEnabled: !self.nickname.text.isEmpty,
                           pushDestination: $pushNextView)
                .padding([.bottom], keyboard.state.height)
                .edgesIgnoringSafeArea((keyboard.state.height > 0) ? [.bottom] : [])
                .animation(.easeOut(duration: keyboard.state.animationDuration))
                .onTapGesture {
                    self.window.endEditing(true)
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
