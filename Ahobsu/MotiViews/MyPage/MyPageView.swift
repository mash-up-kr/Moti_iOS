//
//  MyPageView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/01/26.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct MyPageView: View {

    @ObservedObject var myPageViewModel = MyPageViewModel()
    @ObservedObject var appVersion = AppVersion()
    
    @Binding var isNavigationBarHidden: Bool
    
    var mailCompose = MailCompose()
    
    var body: some View {
        ScrollView {
            VStack {
                HeaderView(name: myPageViewModel.user.name)
                Separator()
                ListCell(title: "닉네임", detail: myPageViewModel.user.name)
                ListCell(title: "생년월일", detail: myPageViewModel.user.birthday)
                ListCell(title: "성별", detail: myPageViewModel.user.gender)
                Separator()
                ListCell(title: "버전정보", detail: "현재 \(appVersion.currentVersion) / 최신 \(appVersion.latestVersion)")
                HStack {
                    Spacer()
                    Button(action: {
                        self.mailCompose.open()
                    }, label: {
                        Text("문의하기")
                    })
                }.frame(minHeight: 52)
                .foregroundColor(Color(.rosegold))
                Spacer()
            }
        }
        .padding(.horizontal, 15)
        .navigationBarTitle("마이페이지", displayMode: .inline)
        .font(.system(size: 16))
        .background(BackgroundView())
        .navigationBarItems(trailing: NavigationLink(destination: MyPageEditView(user: $myPageViewModel.user)) {
            Image("icRewriteNormal").frame(width: 48, height: 48, alignment: .center)
        })
        .onAppear {
            self.isNavigationBarHidden = false
            self.myPageViewModel.getUser()
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView(isNavigationBarHidden: .constant(false))
    }
}

extension MyPageView {

    struct HeaderView: View {
        var name: String
        var body: some View {
            VStack {
                Spacer(minLength: 20)
                Image("imgMypage")
                Spacer(minLength: 16)
                Text("\(name) 님")
                Spacer(minLength: 26)
            }.foregroundColor(Color(.rosegold))
        }
    }

    struct Separator: View {
        var body: some View {
            Rectangle()
                .frame(minHeight: 1, maxHeight: 1)
                .foregroundColor(Color(UIColor.lightgold.withAlphaComponent(0.5)))
        }
    }

    struct ListCell: View {
        var title: String
        var detail: String
        var body: some View {
            HStack {
                Text(title)
                Spacer()
                Text(detail)
            }.frame(minHeight: 52)
            .foregroundColor(Color(.rosegold))
        }
    }
}
