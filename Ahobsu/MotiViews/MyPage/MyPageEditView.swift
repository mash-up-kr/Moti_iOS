//
//  MyPageEditView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/01/27.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI
import Combine

struct MyPageEditView: View {

    @Binding var user: User

    @ObservedObject var keyboard = Keyboard()
    @ObservedObject var myPageEdit = MyPageEdit()

    var body: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 30)
                MyPageView.Separator()
                ListCell(title: "닉네임", content: TextField("", text: $user.name))
                MyPageView.Separator().opacity(0.5)
                ListCell(title: "생년월일", content: DateField(dateString: $user.birthday))
                MyPageView.Separator().opacity(0.5)
                ListCell(title: "성별", content: GenderField(gender: $user.gender))
                MyPageView.Separator()
                ListCell(title: "",
                         content: Button(action: { self.deleteToken(); self.navigateRootView() },
                                         label: { Text("로그아웃") }))
                ListCell(title: "",
                         content: Button(action: { self.myPageEdit.deleteUser() },
                                         label: { Text("탈퇴하기").opacity(0.5) }))
            }
        }
        .padding(.horizontal, 15)
        .padding([.bottom], keyboard.state.height)
        .edgesIgnoringSafeArea((keyboard.state.height > 0) ? [.bottom] : [])
        .animation(.easeOut(duration: keyboard.state.animationDuration))
        .navigationBarTitle("수정하기").onReceive(myPageEdit.$deletingUserSucccess) { (success) in
            if success {
                self.navigateRootView()
            }
        }.onTapGesture {
            self.endEditing()
        }
    }
}

// Helper
extension MyPageEditView {

    private func deleteToken() {
        // TODO: - 토큰 제거를 통한 로그아웃
    }

    private func navigateRootView() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = UIHostingController(rootView: SignInView(window: window))
            UIView.transition(with: window,
                              duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
    private func endEditing() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.endEditing(true)
        }
    }
}

struct MyPageEditView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageEditView(user: .constant(.sampleData))
    }
}

extension MyPageEditView {
    struct ListCell<Content>: View where Content: View {
        var title: String
        var content: Content
        var body: some View {
            HStack(spacing: 50) {
                Text(title).frame(minWidth: 60, alignment: .leading)
                if title.isEmpty {
                    Spacer()
                }
                content
                if title.isEmpty == false {
                    Spacer()
                }
            }.frame(minHeight: 52)
            .foregroundColor(Color(.rosegold))
        }
    }
}
