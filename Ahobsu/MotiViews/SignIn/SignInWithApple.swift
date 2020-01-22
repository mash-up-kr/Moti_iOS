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
        let button = ASAuthorizationAppleIDButton(type: .default, style: .white)
        button.cornerRadius = 22
        return button
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}
