//
//  SignInWithAppleDelegates.swift
//  Ahobsu
//
//  Created by 이호찬 on 2020/01/20.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation
import AuthenticationServices
import Contacts

class SignInWithAppleDelegates: NSObject {
    private let signInSucceeded: (Bool) -> Void
    private weak var window: UIWindow!

    init(window: UIWindow?, onSignedIn: @escaping (Bool) -> Void) {
        self.window = window
        self.signInSucceeded = onSignedIn
    }
}

extension SignInWithAppleDelegates: ASAuthorizationControllerDelegate {
    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential) {
        //    do {
        //      let success = try WebApi.Register(user: userData,
        //                                        identityToken: credential.identityToken,
        //                                        authorizationCode: credential.authorizationCode)
        //      self.signInSucceeded(success)
        //    } catch {
        //      self.signInSucceeded(false)
        //    }

        self.signInSucceeded(true)
    }

    private func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential) {
        // You *should* have a fully registered account here.  If you get back an error from your server
        // that the account doesn't exist, you can look in the keychain for the credentials and rerun setup

        // if (WebAPI.Login(credential.user, credential.identityToken, credential.authorizationCode)) {
        //   ...
        // }
        self.signInSucceeded(true)
    }

    private func signInWithUserAndPassword(credential: ASPasswordCredential) {
        // You *should* have a fully registered account here.  If you get back an error from your server
        // that the account doesn't exist, you can look in the keychain for the credentials and rerun setup

        // if (WebAPI.Login(credential.user, credential.password)) {
        //   ...
        // }
        self.signInSucceeded(true)
    }

    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            if let _ = appleIdCredential.email, let _ = appleIdCredential.fullName {
                registerNewAccount(credential: appleIdCredential)
            } else {
                signInWithExistingAccount(credential: appleIdCredential)
            }

        case let passwordCredential as ASPasswordCredential:
            signInWithUserAndPassword(credential: passwordCredential)

        default:
            break
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

extension SignInWithAppleDelegates: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.window
    }
}
