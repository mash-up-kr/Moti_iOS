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

    var imageTitle: String { "bgSplash" }

    var body: some View {
        Image(imageTitle)
        .resizable()
        .opacity(backgroundAlpha)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct LogoView: View {

    @Binding var textAlpha: Double
    @Binding var logoAlpha: Double
    @Binding var logoScale: CGFloat

    var logoText: String { "Moti" }
    var logoSize: CGFloat { 24 }
    var logoPaddingBottom: CGFloat { 12 }

    var titleText: String { "일상의 동기를 부여하다" }
    var titleColor: Color {
        Color.init(.sRGB,
                    red: 152/255,
                    green: 10/255,
                    blue: 135/255,
                    opacity: 0.34)
    }
    var titleSize: CGFloat { 16 }

    var logoViewPaddingTop: CGFloat { 226 }

    var body: some View {
        VStack {
            Text(logoText)
            .foregroundColor(Color.white)
                .font(.system(size: logoSize, weight: .bold, design: .default))
            .scaleEffect(logoScale)
            .opacity(logoAlpha)
            .padding(.bottom, logoPaddingBottom)
            Text(titleText)
            .foregroundColor(titleColor)
            .font(.system(size: titleSize, weight: .bold, design: .default))
            .opacity(textAlpha)
            Spacer()
        }
        .padding(.top, logoViewPaddingTop)
    }
}

extension SplashView {

    var backgroundAnimationDuration: Double { 1.0 }
    var titleAnimationDuration: Double { 0.5 }
    var logoAnimationDuration: Double { 0.3 }
    var logoAnimationEndDuration: Double { 1.0 }

    var backgroundAlphaFinal: Double { 1.0 }
    var textAlphaFinal: Double { 1.0 }
    var logoAlphaFinal: Double { 1.0 }
    var logoScaleFinal: Double { 1.5 }

    func handleAnimations() {
        runAnimationPart1()
        runAnimationPart2()
        runAnimationPart3()
        goNextView()
    }

    func runAnimationPart1() {
        withAnimation(.easeIn(duration: backgroundAnimationDuration)) {
            backgroundAlpha = self.backgroundAlphaFinal
        }
    }

    func runAnimationPart2() {
        let deadline: DispatchTime = .now()
            + backgroundAnimationDuration
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            withAnimation(.easeIn(duration: self.titleAnimationDuration)) {
                self.textAlpha = self.textAlphaFinal
            }
        }
    }

    func runAnimationPart3() {
        let deadline: DispatchTime = .now()
            + backgroundAnimationDuration
            + titleAnimationDuration
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            withAnimation(.easeIn(duration: self.logoAnimationDuration)) {
                self.logoAlpha = self.logoAlphaFinal
                self.logoScale = CGFloat(self.logoScaleFinal)
            }
        }
    }

    func goNextView() {
        let deadline: DispatchTime = .now()
            + backgroundAnimationDuration
            + titleAnimationDuration
            + logoAnimationDuration
            + logoAnimationEndDuration
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.window.rootViewController = UIHostingController(rootView: SignInView(window: self.window))
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(window: UIWindow())
    }
}
