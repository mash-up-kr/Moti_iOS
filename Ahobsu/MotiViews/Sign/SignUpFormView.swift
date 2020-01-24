//
//  SignUpFormView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SignUpFormView<Content, Destination>: View where Content: View, Destination: View {

    var title: String
    var content: Content
    var buttonTitle: String
    var buttonDestination: Destination
    var buttonAction: (() -> Void)?
    var shouldUseAction: Bool = false
    var buttonEnabled: Bool

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text(title)
                    .font(.system(size: 28))
                    .foregroundColor(Color(.rosegold))
                    .padding(.horizontal, 15)
                    .multilineTextAlignment(.center)
                Spacer()
                content
                Spacer()
                // Next Step
                if shouldUseAction {
                    MainButton(action: self.buttonAction, title: buttonTitle)
                        .environment(\.isEnabled, buttonEnabled)
                } else {
                    NavigationLink(destination: buttonDestination) {
                        MainButton(title: buttonTitle)
                    }.environment(\.isEnabled, buttonEnabled)
                }
                Spacer()
                }.frame(maxHeight: .infinity)
            }
        .edgesIgnoringSafeArea(.vertical)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [.black, Color(red: 26/255, green: 22/255, blue: 22/255)]),
                           startPoint: .top,
                           endPoint: .bottom))

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpFormView(title: "타이틀을 입력해주세요.",
                       content: Text("Content View"),
                       buttonTitle: "다 음",
                       buttonDestination: Text("Next View"),
                       buttonAction: nil,
                       buttonEnabled: false)
    }
}
