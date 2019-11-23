//
//  SignInView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: SignUpNickNameView()) {
                Text("Sign Up")
            }
            NavigationLink(destination: EmptyView()) {
                Text("Sign In")
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignInView()
        }
    }
}
