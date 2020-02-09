//
//  SignUpBirthdateView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SignUpBirthdateView: View {
    
    @Binding var window: UIWindow
    
    @ObservedObject var signUp: SignUp
    
    @State var pushNextView: Bool = false
    
    var body: some View {
        let contentView = HStack {
            HStack {
                DatePicker(selection: $signUp.birthdate,
                           displayedComponents: .date) {
                            EmptyView()
                }.labelsHidden()
            }
        }
        return NavigationMaskingView(titleItem: Text("생년월일 선택"), trailingItem: EmptyView()) {
            SignUpFormView(title: "생년월일을 입력해주세요.",
                                  content: contentView,
                                  buttonTitle: "가입하기",
                                  buttonDestination: SignUpCompleteView(window: self.$window),
                                  buttonAction: { self.signUp.inputComplete = true },
                                  buttonEnabled: true,
                                  pushDestination: $pushNextView).onReceive(signUp.signUpSuccess) { (success) in
                                    self.pushNextView = success
            }
        }
    }
}

struct SignUpBirthdateView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpBirthdateView(window: .constant(UIWindow()),
                            signUp: SignUp())
            .environment(\.horizontalSizeClass, .compact)
    }
}
