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
    
    @State var pushNextView: Bool = false
    @State var gender: String = "미입력"
    
    var body: some View {
        let contentView = HStack {
            ForEach(SignUp.Gender.allCases, id: \.self) { (gender) in
                Button(action: {
                    self.gender = gender.rawValue
                }, label: {
                    GenderCardView(gender: gender)
                }).padding(.horizontal, 15.0)
                    .opacity((gender.rawValue == self.gender) ? 1 : 0.5)
                    .animation(.easeOut)
            }
        }
        return NavigationMaskingView(titleItem: Text("성별 선택"), trailingItem: EmptyView()) {
            SignUpFormView(title: "성별을 입력해주세요.",
                                  content: contentView,
                                  buttonTitle: "다음",
                                  buttonDestination: SignUpBirthdateView(window: $window, signUp: signUp),
                                  buttonAction: {
                                    self.signUp.gender = self.gender
                                    self.pushNextView = true
            },
                                  buttonEnabled: SignUp.Gender(rawValue: self.gender) != nil,
                                  pushDestination: $pushNextView,
                                  canSkip: true,
                                  skipAction: {
                                    self.signUp.gender = "미입력"
                                    self.pushNextView = true
            })
                .buttonStyle(PlainButtonStyle())
        }
    }
}

struct SignUpGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpGenderView(window: .constant(UIWindow()), signUp: SignUp())
    }
}
