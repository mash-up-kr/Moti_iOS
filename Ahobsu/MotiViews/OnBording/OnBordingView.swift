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
                                  currentPage: $currentPage)
                OnBordingPageViewController(controllers: viewControllers, currentPage: $currentPage)
            }
            VStack {
                if currentPage == models.count - 1 {
                    Spacer()
                    MainButton(action: {
                        KeyChain.save(key: "ahobsu_onbording", data: "success".data(using: .utf8)!)
                        self.window.rootViewController = UIHostingController(rootView: SignInView(window: self.window))
                    }, title: "시작하기")
                }
            }
                .padding(.bottom, 43.0)
                .edgesIgnoringSafeArea([.vertical])
        }
    }
}

struct OnBordingView_Previews: PreviewProvider {

    static var previews: some View {

        return Group {
            OnBordingView(window: UIWindow(), model: OnBordingModel.createOnBordingModel())
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}
