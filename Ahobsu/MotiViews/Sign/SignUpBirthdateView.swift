//
//  SignUpBirthdateView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI
import Combine

struct SignUpBirthdateView: View {
    
    @Binding var window: UIWindow
    
    @ObservedObject var signUp: SignUp
    
    @State var birthdate = Date()
    
    let dateFormmater: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFullDate
        return formatter
    }()
    
    var body: some View {
        let contentView = DatePickerView(selection: $birthdate)
            .background(Color(red: 0.051, green: 0.043, blue: 0.043))
        return NavigationMaskingView(titleItem: Text("생년월일 선택"), trailingItem: EmptyView()) {
            SignUpFormView(title: "생년월일을 입력해주세요.",
                                  content: contentView,
                                  buttonTitle: "가입하기",
                                  buttonDestination: SignUpCompleteView(window: self.$window),
                                  buttonAction: {
                                    self.signUp.birthdate = self.dateFormmater.string(from: self.birthdate)
                                    self.signUp.updateProfile()
            },
                                  buttonEnabled: true,
                                  pushDestination: $signUp.signUpSuccess,
                                  canSkip: true,
                                  skipAction: {
                                    self.signUp.birthdate = "미입력"
                                    self.signUp.updateProfile()
            })
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
