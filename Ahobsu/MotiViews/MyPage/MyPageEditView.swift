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
    
    @ObservedObject var keyboard = Keyboard()
    @ObservedObject var myPageEdit = MyPageEdit()
    
    @Binding var sourceUser: User
    @State var editingUser: User
    @State var isNetworking = false
    
    var body: some View {
        NavigationMaskingView(titleItem: Text("수정하기"), trailingItem: Text("")) {
            ScrollView {
                VStack {
                    Spacer(minLength: CGFloat(30))
                    MyPageView.Separator()
                    VStack {
                        ListCell(title: "닉네임", content: TextField("", text: $editingUser.name))
                        MyPageView.Separator().opacity(0.5)
                        ListCell(title: "생년월일", content: DateField(dateString: $editingUser.birthday))
                        MyPageView.Separator().opacity(0.5)
                        ListCell(title: "성별", content: GenderField(gender: $editingUser.gender))
                    }
                    MyPageView.Separator()
                    ListCell(title: "",
                             content: Button(action: { self.logout() },
                                             label: { Text("로그아웃") }))
                    ListCell(title: "",
                             content: Button(action: { self.myPageEdit.deleteUser() },
                                             label: { Text("탈퇴하기").opacity(0.5) }))
                    Spacer()
                    MainButton(action: { self.updateUser() },
                               title: "저장하기")
                        .environment(\.isEnabled, (!isNetworking && (sourceUser != editingUser)))
                    Spacer(minLength: 75)
                }
            }
            .padding(.horizontal, 15)
            .padding([.bottom], keyboard.state.height)
            .background(BackgroundView().edgesIgnoringSafeArea(.vertical))
            .edgesIgnoringSafeArea((keyboard.state.height > 0) ? [.bottom] : [])
            .animation(.easeOut(duration: keyboard.state.animationDuration))
            .onReceive(myPageEdit.$deletingUserSucccess) { (success) in
                if success {
                    // 토큰 제거
                    TokenManager.sharedInstance.resetTokensFromKeyChain(completion: { (status) in
                        // SignIn 화면으로 이동
                        self.navigateRootView()
                    }, error: { (status) in
                        
                    })
                }
            }.onTapGesture {
                self.endEditing()
            }.onDisappear {
                self.editingUser = self.sourceUser
            }
        }
    }
}

// Helper
extension MyPageEditView {
    
    private func updateUser() {
        guard isNetworking == false else { return }
        isNetworking = true
        AhobsuProvider.updateProfile(user: editingUser, completion: { (response) in
            if response?.status == 200 {
                self.sourceUser = self.editingUser
            }
            self.isNetworking = false
        }, error: { (error) in
            self.isNetworking = false
        }, expireTokenAction: {
            self.isNetworking = false
        }, filteredStatusCode: nil)
    }
    
    private func logout() {
        // 토큰 제거
        TokenManager.sharedInstance.resetTokensFromKeyChain(completion: { (status) in
            // SignIn 화면으로 이동
            self.navigateRootView()
        }, error: { (status) in
            
        })
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
        MyPageEditView(sourceUser: .constant(.placeholderData), editingUser: .placeholderData)
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
