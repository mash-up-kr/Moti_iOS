//
//  SignUpNickNameView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SignUpNickNameView: View {

    @State var nickName: String = ""

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("닉네임을 입력해주세요.").font(.system(size: 28))
                Spacer()
                TextField("",
                          text: $nickName,
                          onEditingChanged: { (_) in
                            // Next Step
                },
                          onCommit: {
                            // Next Step
                }).background(Divider().foregroundColor(Color.black),
                              alignment: .bottom)
                    .padding(.horizontal, 66)
                Spacer()
                Button(action: {
                    // Next Step
                }, label: {
                    Text("다 음").font(.system(size: 19))
                }).foregroundColor(.white)
                    .padding(20)
                    .frame(minWidth: 243,
                           minHeight: 58,
                           alignment: .center)
                    .background(Color(red: 0.325, green: 0.326, blue: 0.325))
                    .cornerRadius(29)
                Spacer()
                }.frame(maxHeight: .infinity)
        }
    }
}

struct SignUpNameView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpNickNameView()
    }
}
