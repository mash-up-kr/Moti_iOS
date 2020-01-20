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

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SignUpNickNameView(window: $window)) {
                    Text("Sign Up")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Sign In")
                }
                SignWithApple()
                    .onTapGesture(perform: showAppleLogin)
                    .frame(height: 60, alignment: .center)
                    .padding(.horizontal, 20)

            }
        }
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
      appleSignInDelegates = SignInWithAppleDelegates(window: window) { success in
        if success {
            // update UI
            self.window.rootViewController = UIHostingController(
                rootView: NavigationView { SignUpNickNameView(window: self.$window) }
            )
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
