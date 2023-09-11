//
//  SignInView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    
    @State var window: UIWindow
    @State var isDone = false
    @State var showingOnBordingView = true
    
    var linkUserAgreement: String { "https://notion.so/ahobsu/MOTI-35d01dd331bb4aa0915c33d28d60b63c" }
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                    .edgesIgnoringSafeArea([.top, .bottom])
                VStack {
                    Spacer()
                    VStack(spacing: 24) {
                        Image("motiLogo")
                        Text("Make Own True Identity")
                            .font(.custom("TTNorms-Regular", size: 16))
                            .foregroundColor(Color(UIColor.rosegold))
                    }
                    .offset(x: 0, y: -100)
                    Spacer()
                    VStack {
                        SignInWithAppleButton(
                            onRequest: { request in
                                request.requestedScopes = [.fullName, .email]
                            },
                            onCompletion: signInOnCompletion
                        )
                        .signInWithAppleButtonStyle(.white)
                        .frame(height: 44, alignment: .center)
                        .cornerRadius(22)
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 23)
                    Text("By creating an account you are agreeing to")
                        .font(.custom("AppleSDGothicNeo-Regular", size: 12))
                        .foregroundColor(Color(UIColor.rosegold))
                        .padding(.bottom, 8)
                    Text("MOTI's User Agreement")
                        .font(.custom("AppleSDGothicNeo-Regular", size: 12))
                        .foregroundColor(Color(UIColor.rosegold))
                        .underline(true, color: Color(UIColor.rosegold))
                        .onTapGesture {
                            UIApplication.shared.open(URL(string: self.linkUserAgreement)!)
                        }.padding([.bottom], 40.0)
                }
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
    
    private func signInOnCompletion(result: Result<ASAuthorization, Error>) -> Void {
        switch result {
        case .success(let authResults):
            switch authResults.credential{
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                let id = String(decoding: appleIDCredential.identityToken ?? Data(), as: UTF8.self)
                let auth = String(decoding: appleIDCredential.authorizationCode ?? Data(), as: UTF8.self)
                
                AhobsuProvider.signIn(snsId: auth, auth: id, completion: { wrapper in
                    if let signInToken = wrapper?.data {
                        if signInToken.signUp {
                            TokenManager.sharedInstance.registerAccessToken(token: signInToken.accessToken,
                                                                            completion: nil,
                                                                            error: nil)
                            TokenManager.sharedInstance.registerRefreshToken(token: signInToken.refreshToken,
                                                                             completion: nil,
                                                                             error: nil)
                        } else {
                            TokenManager.sharedInstance.temporaryAccessToken = signInToken.accessToken
                            TokenManager.sharedInstance.temporaryRefreshToken = signInToken.refreshToken
                        }
                        self.signInSucceeded(success: true, haveAccount: signInToken.signUp)
                    } else {
                        self.signInSucceeded(success: false, haveAccount: nil)
                    }
                }, error: { err in
                    self.signInSucceeded(success: false, haveAccount: nil)
                }, expireTokenAction: {
                    // Empty
                }, filteredStatusCode: nil)
            default:
                break
            }
        case .failure(_):
            self.signInSucceeded(success: false, haveAccount: nil)
        }
    }
    
    private func signInSucceeded(success: Bool, haveAccount: Bool?) {
        if success, let haveAccount = haveAccount {
            // update UI
            if haveAccount {
                self.window.rootViewController = UIHostingController(rootView: MainView(window: self.window))
            } else {
                self.window.rootViewController = UIHostingController(rootView: NavigationView { SignUpNickNameView(window: self.$window) })
            }
        } else {
            // show the user an error
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(window: UIWindow())
    }
}
