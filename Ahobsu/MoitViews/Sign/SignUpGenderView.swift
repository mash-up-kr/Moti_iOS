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
    var genders: [String] = ["남성", "여성"]
    @State var gender: String = ""

    var body: some View {
        let contentView = HStack {
            ForEach(genders, id: \.self) { (gender) in
                Button(action: {
                    self.gender = gender
                }, label: {
                    Text(gender).foregroundColor(.black)
                }).padding(.horizontal, 32)
                    .padding(.vertical, 38)
                    .background(Color.gray)
                    .border(Color.black)
            }
        }
        return SignUpFormView(title: "성별을 입력해주세요.",
                              content: contentView,
                              buttonTitle: "다음",
                              buttonDestination: SignUpBirthdateView(window: $window))
    }
}

struct SignUpGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpGenderView(window: .constant(UIWindow()))
    }
}
