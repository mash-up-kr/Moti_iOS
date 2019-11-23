//
//  SignUpGenderView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SignUpGenderView: View {

    var genders: [String] = ["남성", "여성"]
    @State var gender: String = ""

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("성별을 입력해주세요.").font(.system(size: 28))
                Spacer()
                HStack {
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
                Spacer()
                // Next Step
                NavigationLink(destination: EmptyView()) {
                    Text("다 음").font(.system(size: 19))
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

struct SignUpGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpGenderView()
    }
}
