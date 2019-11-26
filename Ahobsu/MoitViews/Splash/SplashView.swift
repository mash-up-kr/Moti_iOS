//
//  SlashView.swift
//  Ahobsu
//
//  Created by admin on 2019/11/26.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            LogoView()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundView: View {
    var body: some View {
        Image("bgSplash")
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .frame(width: .infinity, height: .infinity)
    }
}

struct LogoView: View {
    var body: some View {
        VStack {
            Text("Moti")
            .foregroundColor(Color.white)
            .font(.system(size: 24, weight: .bold, design: .default))
            Text("일상의 동기를 부여하다")
                .foregroundColor(Color.init(red: 152/1255, green: 10/255, blue: 135/255))
                .font(.system(size: 16, weight: .bold, design: .default))
            Spacer()
        }
        .padding(.top, 226.0)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
