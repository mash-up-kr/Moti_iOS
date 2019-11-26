//
//  SlashView.swift
//  Ahobsu
//
//  Created by admin on 2019/11/26.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SplashView: View {

    @State var window: UIWindow

    @State var backgroundAlpha = 0.0

    @State var textAlpha = 0.0

    @State var logoAlpha = 0.0
    @State var logoScale: CGFloat = 1

    var body: some View {
        ZStack {
            BackgroundView(backgroundAlpha: $backgroundAlpha)
            LogoView(textAlpha: $textAlpha,
                     logoAlpha: $logoAlpha,
                     logoScale: $logoScale)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.handleAnimations()
        }
    }
}

struct BackgroundView: View {

    @Binding var backgroundAlpha: Double

    var body: some View {
        Image("bgSplash")
        .resizable()
        .opacity(backgroundAlpha)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct LogoView: View {

    @Binding var textAlpha: Double
    @Binding var logoAlpha: Double
    @Binding var logoScale: CGFloat

    var body: some View {
        VStack {
            Text("Moti")
            .foregroundColor(Color.white)
            .font(.system(size: 24, weight: .bold, design: .default))
            .scaleEffect(logoScale)
            .opacity(logoAlpha)
            .padding(.bottom, 12)
            Text("일상의 동기를 부여하다")
            .foregroundColor(Color.init(.sRGB, red: 152/255, green: 10/255, blue: 135/255, opacity: 0.34))
            .font(.system(size: 16, weight: .bold, design: .default))
            .opacity(textAlpha)
            Spacer()
        }
        .padding(.top, 226.0)
    }
}

extension SplashView {

    var backgroundAnimationDuration: Double { 1.0 }
    var titleAnimationDuration: Double { 0.5 }
    var logoAnimationDuration: Double { 0.3 }

    func handleAnimations() {
        runAnimationPart1()
        runAnimationPart2()
        runAnimationPart3()
    }

    func runAnimationPart1() {
        withAnimation(.easeIn(duration: backgroundAnimationDuration)) {
            backgroundAlpha = 1.0
        }
    }

    func runAnimationPart2() {
        let deadline: DispatchTime = .now() + backgroundAnimationDuration
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            withAnimation(.easeIn(duration: self.titleAnimationDuration)) {
                self.textAlpha = 1.0
            }
        }
    }

    func runAnimationPart3() {
        let deadline: DispatchTime = .now() + backgroundAnimationDuration + titleAnimationDuration
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            withAnimation(.easeIn(duration: self.logoAnimationDuration)) {
                self.logoAlpha = 1.0
                self.logoScale = 1.5
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(window: UIWindow())
    }
}
