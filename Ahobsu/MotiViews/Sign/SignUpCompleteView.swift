//
//  SignUpCompleteView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/11/24.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SignUpCompleteView: View {

    @Binding var window: UIWindow
    var nickname: String = UserDefaults.standard.string(forKey: "SignUp.Nickname") ?? "unknown"

    var body: some View {
        SignUpFormView(title: "\(nickname)님\n회원가입을\n축하합니다!",
                       content: EmptyView(),
                       buttonTitle: "시작하기",
                       buttonDestination: EmptyView(),
                       buttonAction: {
                        self.window.rootViewController = UIHostingController(rootView: MainView())
        },
                       shouldUseAction: true,
                       buttonEnabled: true)
    }
}

struct SignUpCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpCompleteView(window: .constant(UIWindow()))
    }
}
