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
    @State var birthdate: Date = Date()

    var body: some View {
        let contentView = HStack {
            HStack {
                DatePicker(selection: $birthdate,
                           displayedComponents: .date) {
                    EmptyView()
                }.labelsHidden()
            }
        }
        return SignUpFormView(title: "생년월일을 입력해주세요.",
                              content: contentView,
                              buttonTitle: "가입하기",
                              buttonDestination: SignUpCompleteView(window: $window))
    }
}

struct SignUpBirthdateView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpBirthdateView(window: .constant(UIWindow())).environment(\.horizontalSizeClass, .compact)
    }
}
