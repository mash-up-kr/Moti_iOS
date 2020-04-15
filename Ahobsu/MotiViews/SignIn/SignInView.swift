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
    @State var appleSignInDelegates: SignInWithAppleDelegates! = nil
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
                    SignWithApple()
                        .onTapGesture(perform: showAppleLogin)
                        .frame(height: 60, alignment: .center)
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
        .onAppear {
            self.performExistingAccountSetupFlows()
        }
    }
    
    private func showAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        performSignIn(using: [request])
    }
    private func performExistingAccountSetupFlows() {
        #if !targetEnvironment(simulator)
        // Note that this won't do anything in the simulator.  You need to
        // be on a real device or you'll just get a failure from the call.
        let requests = [
            ASAuthorizationAppleIDProvider().createRequest(),
            ASAuthorizationPasswordProvider().createRequest()
        ]
        
        performSignIn(using: requests)
        #endif
    }
    
    private func performSignIn(using requests: [ASAuthorizationRequest]) {
        appleSignInDelegates = SignInWithAppleDelegates(window: window) { (success, haveAccount) in
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
        
        let controller = ASAuthorizationController(authorizationRequests: requests)
        controller.delegate = appleSignInDelegates
        controller.presentationContextProvider = appleSignInDelegates
        
        controller.performRequests()
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(window: UIWindow())
    }
}
