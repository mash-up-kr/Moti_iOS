//
//  SignInWithApple.swift
//  Ahobsu
//
//  Created by 이호찬 on 2020/01/20.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI
import AuthenticationServices

final class SignWithApple: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton

    func makeUIView(context: Context) -> UIViewType {
        return ASAuthorizationAppleIDButton()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}
