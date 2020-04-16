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

struct SignIn: Codable {
    var status: Int
    var message: String
    var data: TokenData
    
    struct TokenData: Codable {
        var accessToken: String
        var refreshToken: String
        var signUp: Bool
    }
}

class SignInWithAppleDelegates: NSObject {
    typealias SignInResult = (Bool, Bool?) -> Void
    private let signInSucceeded: SignInResult
    private weak var window: UIWindow!
    
    init(window: UIWindow?, onSignedIn: @escaping SignInResult) {
        self.window = window
        self.signInSucceeded = onSignedIn
    }
}

extension SignInWithAppleDelegates: ASAuthorizationControllerDelegate {
    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential) {
        let id = String(decoding: credential.identityToken ?? Data(), as: UTF8.self)
        let auth = String(decoding: credential.authorizationCode ?? Data(), as: UTF8.self)
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
                self.signInSucceeded(true, signInToken.signUp)
            } else {
                self.signInSucceeded(false, nil)
            }
        }, error: { err in
//             print(err)
            self.signInSucceeded(false, nil)
        }, expireTokenAction: {
            
        }, filteredStatusCode: nil)
    }
    
    private func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential) {
        let id = String(decoding: credential.identityToken ?? Data(), as: UTF8.self)
        let auth = String(decoding: credential.authorizationCode ?? Data(), as: UTF8.self)
        AhobsuProvider.signIn(snsId: auth, auth: id, completion: { wrapper in
            if let signInToken = wrapper?.data {
                if signInToken.signUp {
                    TokenManager.sharedInstance.registerAccessToken(token: signInToken.accessToken,
                                                                    completion: nil,
                                                                    error: nil)
                    TokenManager.sharedInstance.registerRefreshToken(token: signInToken.refreshToken,
                                                                     completion: nil,
                                                                     error: nil)
                    self.signInSucceeded(true, true)
                } else {
                    TokenManager.sharedInstance.temporaryAccessToken = signInToken.accessToken
                    TokenManager.sharedInstance.temporaryRefreshToken = signInToken.refreshToken
                    self.signInSucceeded(true, false)
                }
            } else {
                self.signInSucceeded(false, nil)
            }
        }, error: { err in
//             print(err)
            self.signInSucceeded(false, nil)
        }, expireTokenAction: {
            
        }, filteredStatusCode: nil)
    }
    
    private func signInWithUserAndPassword(credential: ASPasswordCredential) {
        // You *should* have a fully registered account here.  If you get back an error from your server
        // that the account doesn't exist, you can look in the keychain for the credentials and rerun setup
        
        // if (WebAPI.Login(credential.user, credential.password)) {
        //   ...
        // }
        self.signInSucceeded(true, nil)
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            if let email = appleIdCredential.email, let _ = appleIdCredential.fullName {
                UserDefaults.standard.set(email, forKey: "com.ahobsu.AppleID")
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
