//
//  AnswerComplete.swift
//  Ahobsu
//
//  Created by admin on 2020/01/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//
import SwiftUI

struct OnBordingView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var currentPage = 0
    
    var window: UIWindow
    
    var viewControllers: [UIHostingController<OnBordingCardView>]
    
    var models: [OnBordingModel]
    
    @State private var buttonOpacity: Double = 0.0
    
    var buttonPaddingBottom: CGFloat { 43.0 }
    
    var titleMainButton: String { "시작하기" }
    
    init(window: UIWindow, model: [OnBordingModel]) {
        self.models = model
        self.window = window
        
        self.viewControllers = model.map({
            let controller = UIHostingController(rootView: OnBordingCardView(onBordingModel: $0))
            
            controller.view.backgroundColor = UIColor.clear
            
            return controller
        })
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
                .edgesIgnoringSafeArea([.vertical])
            VStack {
                OnBordingPageControl(numberOfPages: viewControllers.count,
                                     currentPage: $currentPage,
                                     buttonOpacity: $buttonOpacity)
                    .frame(height: 72.0)
                OnBordingPageViewController(controllers: viewControllers,
                                            currentPage: $currentPage,
                                            buttonOpacity: $buttonOpacity)
            }
            VStack {
                Spacer()
                MainButton(action: {
                    let _ = KeyChain.save(key: "ahobsu_onbording", data: "success".data(using: .utf8)!)
                    self.window.rootViewController = UIHostingController(rootView: SignInView(window: self.window))
                }, title: titleMainButton)
                .opacity(buttonOpacity)
            }
            .padding(.bottom, buttonPaddingBottom)
        }
    }
}
