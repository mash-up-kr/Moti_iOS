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
    var destination: Destination

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text(title).font(.system(size: 28))
                Spacer()
                content
                Spacer()
                // Next Step
                NavigationLink(destination: destination) {
                    Text(buttonTitle).font(.system(size: 19))
                        .foregroundColor(.white)
                        .padding(20)
                        .frame(minWidth: 243, minHeight: 58, alignment: .center)
                        .background(Color(red: 0.325, green: 0.326, blue: 0.325))
                        .cornerRadius(29)
                }
                Spacer()
                }.frame(maxHeight: .infinity)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpFormView(title: "타이틀을 입력해주세요.",
                       content: Text("Content View"),
                       buttonTitle: "다 음",
                       destination: Text("Next View"))
    }
}
