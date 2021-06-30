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
    @State var showCamera = false
    @State private var appVersion: AppVersion = .placeholderData
    @State private var showingAccessTokenAlert = false
    @State private var showingRefreshTokenAlert = false
    @State private var editViewActive = false
    
    @State private var activeSheet: ActiveSheet?

    @ObservedObject var intent: MyPageIntent = MyPageIntent.shared
    
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
                              }),
                              isHiddenLeftButton: true)
        {
            ScrollView {
                VStack {
                    HeaderView(image: $intent.image, activeSheet: $activeSheet, name: intent.user.name)
                    Separator()
                    ListCell(title: "닉네임", detail: intent.user.name)
                    ListCell(title: "생년월일", detail: intent.user.birthday)
                    ListCell(title: "성별", detail: intent.user.gender)
                    Separator()
                    ListCell(title: "버전정보", detail: "현재 \(appVersion.currentVersion)")
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
                            self.activeSheet = .privacy
                        }, label: {
                            Text("개인정보취급방침 및 이용약관")
                        })
                    }.frame(minHeight: 52)
                    .foregroundColor(Color(.rosegold))
                }.padding(.horizontal, 15)
            }
            .font(.system(size: 16))
        }
        .background(BackgroundView().edgesIgnoringSafeArea(.vertical))
        .sheet(item: $activeSheet) {
            switch $0 {
            case .imagePicker:
                ImagePicker(showCamera: self.$showCamera,
                            image: self.$intent.image,
                            isStatusBarHidden: .constant(false),
                            sourceType: .photoLibrary,
                            isFiltered: true) {
                    self.intent.updateImage($0)
                }

            case .privacy:
                NavigationView {
                    WebView(url: self.privacyURL)
                        .navigationBarItems(trailing: Button(action: { self.activeSheet = nil },
                                                             label: { Text("OK") })).navigationBarTitle("", displayMode: .inline)
                }
            }
        }
        .onReceive(AppVersion.versionPubliser) { (fetchedVersion) in
            self.appVersion = fetchedVersion
        }
        .onAppear(perform: intent.onAppear)
    }
    
    enum ActiveSheet: Identifiable {
        case imagePicker, privacy
        
        var id: Int {
            hashValue
        }
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
        @Binding var image: UIImage?
        @Binding var activeSheet: ActiveSheet?

        var name: String
        var body: some View {
            VStack {
                Spacer(minLength: 8)
                ZStack {
                    Circle()
                        .strokeBorder(Color(.rosegold), lineWidth: image == nil ? 2 : 1)
                        .background(Circle().foregroundColor(.clear))
                        .frame(width: 110, height: 110)
                    
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .cornerRadius(55)
                            .clipped()
                            .onTapGesture {
                                self.activeSheet = .imagePicker
                            }
                    } else {
                        Image("icCameraEmpty")
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                self.activeSheet = .imagePicker
                            }
                    }
                }
                Spacer(minLength: 16)
                Text("\(name) 님")
                Spacer(minLength: 26)
            }
            .foregroundColor(Color(.rosegold))
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
