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
    var genders: [Bool] = [true, false]
    @State var gender: String = ""
    var isMaleSelected: Bool {
        return (gender == "male")
    }
    var isFemaleSelected: Bool {
        return (gender == "female")
    }
    var buttonEnabled: Bool {
        return !gender.isEmpty
    }

    var body: some View {
        let contentView = HStack {
            ForEach(genders, id: \.self) { (gender) in
                Button(action: {
                    self.gender = (gender == true) ? "male" : "female"
                }, label: {
                    GenderCardView(isMale: gender)
                }).padding(.horizontal, 15)
                    .opacity((gender == true) ? (self.isMaleSelected ? 1 : 0.5) : (self.isFemaleSelected ? 1 : 0.5))
                    .animation(.easeOut)
            }
        }
        return SignUpFormView(title: "성별을 입력해주세요.",
                              content: contentView,
                              buttonTitle: "다음",
                              buttonDestination: SignUpBirthdateView(window: $window),
                              buttonEnabled: buttonEnabled)
            .buttonStyle(PlainButtonStyle())
    }
}

struct SignUpGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpGenderView(window: .constant(UIWindow()))
    }
}
