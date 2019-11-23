//
//  SignInView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SignInView: View {

    @State var window: UIWindow

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SignUpNickNameView(window: $window)) {
                    Text("Sign Up")
                }
                NavigationLink(destination: EmptyView()) {
                    Text("Sign In")
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(window: UIWindow())
    }
}
