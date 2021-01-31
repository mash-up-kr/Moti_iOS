//
//  MyPageView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/01/26.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI
import Combine

struct MyPageView: View {
    
    @State private var appVersion: AppVersion = .placeholderData
    @State private var privacyIsPresented = false
    @State private var showingAccessTokenAlert = false
    @State private var showingRefreshTokenAlert = false
    @State private var editViewActive = false

    @ObservedObject var intent: MyPageIntent = MyPageIntent()
    
    var mailCompose = MailCompose()
    let privacyURL = URL(string: "https://www.notion.so/88f6a0fc95e747edb054205e057bcb5a?v=38d66de9448f4360ae7460db6fd79026")!
    
    var body: some View {
        NavigationMaskingView(titleItem: Text("마이페이지"),
                              trailingItem: NavigationLink(destination: MyPageEditView(sourceUser: $intent.user,
                                                                                       isViewActive: $editViewActive),
                                                           isActive: $editViewActive,
                                                           label: {
                                                            Image("icRewriteNormal")
                                                                .renderingMode(.original)
                                                                .frame(width: 48, height: 48)
                              }))
        {
            ScrollView {
                VStack {
                    HeaderView(name: intent.user.name)
                    Separator()
                    ListCell(title: "닉네임", detail: intent.user.name)
                    ListCell(title: "생년월일", detail: intent.user.birthday)
                    ListCell(title: "성별", detail: intent.user.gender)
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
                    HStack {
                        Spacer()
                        Button(action: {
                            self.privacyIsPresented.toggle()
                        }, label: {
                            Text("개인정보취급방침 및 이용약관")
                        })
                    }.frame(minHeight: 52)
                        .foregroundColor(Color(.rosegold))
                    // MARK: 토큰값 볼 수 있는 버튼 추
//                    VStack {
//                        HStack {
//                            Spacer()
//                            Button(action: {
//                                UIPasteboard.general.string = TokenManager.sharedInstance.getAccessToken()
//                                self.showingAccessTokenAlert = true
//                            }, label: {
//                                Text("액세스 토큰 값 복사하기")
//                            })
//                            .alert(isPresented: $showingAccessTokenAlert) { () -> Alert in
//                                Alert(title: Text("액세스 토큰 복사"), message: Text("클립보드에 복사했습니다."))
//                            }
//                        }.frame(minHeight: 52)
//                            .foregroundColor(Color(.rosegold))
//                        HStack {
//                            Spacer()
//                            Button(action: {
//                                UIPasteboard.general.string = TokenManager.sharedInstance.getRefreshToken()
//                                self.showingRefreshTokenAlert = true
//                            }, label: {
//                                Text("리프레쉬 토큰 값 복사하기")
//                            })
//                            .alert(isPresented: $showingRefreshTokenAlert) { () -> Alert in
//                                Alert(title: Text("리프레쉬 토큰 복사"), message: Text("클립보드에 복사했습니다."))
//                            }
//                        }.frame(minHeight: 52)
//                            .foregroundColor(Color(.rosegold))
//                        Spacer()
//                    }
                }.padding(.horizontal, 15)
            }
            .font(.system(size: 16))
        }
        .background(BackgroundView().edgesIgnoringSafeArea(.vertical))
        .sheet(isPresented: $privacyIsPresented) {
            NavigationView {
                WebView(url: self.privacyURL)
                    .navigationBarItems(trailing: Button(action: { self.privacyIsPresented.toggle() },
                                                         label: { Text("OK") })).navigationBarTitle("", displayMode: .inline)
            }
        }.onReceive(AppVersion.versionPubliser) { (fetchedVersion) in
            self.appVersion = fetchedVersion
        }.onAppear(perform: intent.onAppear)
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyPageView()
                .previewDevice(.init(rawValue: "iPhone 8"))
            
            MyPageView()
                .previewDevice(.init(rawValue: "iPhone 11"))
        }
    }
}

extension MyPageView {
    
    struct HeaderView: View {
        var name: String
        var body: some View {
            VStack {
                Spacer(minLength: 8)
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
