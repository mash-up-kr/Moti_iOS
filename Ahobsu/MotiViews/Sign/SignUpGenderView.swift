//
//  SignUpGenderView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SignUpGenderView: View {

    @Binding var window: UIWindow

    @ObservedObject var signUp: SignUp

    var body: some View {
        let contentView = HStack {
            ForEach(SignUp.Gender.allCases, id: \.self) { (gender) in
                Button(action: {
                    self.signUp.gender = gender
                }, label: {
                    GenderCardView(gender: gender)
                }).padding(.horizontal, 15.0)
                    .opacity((gender == self.signUp.gender) ? 1 : 0.5)
                    .animation(.easeOut)
            }
        }
        return SignUpFormView(title: "성별을 입력해주세요.",
                              content: contentView,
                              buttonTitle: "다음",
                              buttonDestination: SignUpBirthdateView(window: $window, signUp: signUp),
                              buttonEnabled: signUp.gender != nil)
            .buttonStyle(PlainButtonStyle())
    }
}

struct SignUpGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpGenderView(window: .constant(UIWindow()), signUp: SignUp())
    }
}
