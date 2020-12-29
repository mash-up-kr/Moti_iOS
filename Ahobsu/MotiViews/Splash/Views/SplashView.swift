//
//  SlashView.swift
//  Ahobsu
//
//  Created by 김선재 on 2019/11/26.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI
import AVFoundation

struct SplashView: View {
    
    @State var window: UIWindow
    
    @State var backgroundAlpha = 0.0
    
    @State var textAlpha = 0.0
    
    @State var logoAlpha = 0.0
    @State var logoScale: CGFloat = 1
    
    @ObservedObject var myPageViewModel: MyPageViewModel = .shared
    
    var body: some View {
        VStack {
            LogoView(textAlpha: $textAlpha,
                     logoAlpha: $logoAlpha,
                     logoScale: $logoScale)
        }
        .onAppear {
            self.handleAnimations()
        }
    }
}

struct LogoView: View {
    
    @Binding var textAlpha: Double
    @Binding var logoAlpha: Double
    @Binding var logoScale: CGFloat
    
    var logoName: String { "motiLogo" }
    var logoPaddingBottom: CGFloat { 24.0 }
    
    var titleText: String { "Make Own True Identity" }
    var titleColor: Color { Color.init(.sRGB,
                   red: 245/255,
                   green: 219/255,
                   blue: 203/255,
                   opacity: 1.0)
    }
    var titleSize: CGFloat { 16.0 }
    var titlePaddingBottom: CGFloat { 8.0 }
    
    var body: some View {
        VStack {
            Spacer()
            Image(logoName)
                .scaleEffect(logoScale)
                .opacity(logoAlpha)
                .padding(.bottom, logoPaddingBottom)
            Text(titleText)
                .foregroundColor(titleColor)
                .font(.custom("TTNorms-Regular", size: 16.0))
                .opacity(textAlpha)
                .padding(.bottom, titlePaddingBottom)
            PlayerView()
                .frame(width: 272, height: 400)
            Spacer()
        }
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
    var logoScaleFinal: Double { 1.0 }
    
    func handleAnimations() {
        runAnimationPart1()
        runAnimationPart2()
        goNextView()
    }
    
    func runAnimationPart1() {
        let deadline: DispatchTime = .now()
            + backgroundAnimationDuration
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            withAnimation(.easeIn(duration: self.titleAnimationDuration)) {
                self.textAlpha = self.textAlphaFinal
            }
        }
    }
    
    func runAnimationPart2() {
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
            if KeyChain.load(key: "ahobsu_onbording") != nil {
                /* AccessKey 가 활성화 되어있으면 바로 로그인 */
                if (TokenManager.sharedInstance.getAccessToken() != "") {
                    self.window.rootViewController = UIHostingController(rootView: MainView(window: self.window))
                } else {
                    self.window.rootViewController = UIHostingController(rootView: SignInView(window: self.window))
                }
            } else {
                self.window.rootViewController = UIHostingController(rootView: OnBordingView(window: self.window,  model: OnBordingModel.createOnBordingModel()))
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(window: UIWindow())
    }
}
