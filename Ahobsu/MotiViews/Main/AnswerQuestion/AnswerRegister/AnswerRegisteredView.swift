//
//  AnswerRegisteredView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/02/09.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerRegisteredView: View {
    var body: some View {
        NavigationMaskingView(isRoot: true, titleItem: Text("미션 완료"), trailingItem: EmptyView()) {
            ZStack {
                BackgroundView()
                VStack {
                    Spacer()
                    Text("오늘의 질문에 답변을\n완료했습니다.").multilineTextAlignment(.center)
                        .foregroundColor(Color(.rosegold))
                        .font(.custom("IropkeBatangOTFM", size: 24.0))
                        .lineSpacing(10.0)
                        .padding(.bottom, 12.0)
                    Text("새로운 파츠를 얻었어요. 확인해볼까요?")
                        .foregroundColor(Color(.rosegold))
                        .font(.custom("IropkeBatangOTFM", size: 14.0))
                        .lineSpacing(22.0)
                        .padding(.bottom, 28.0)
                    Image("imgMypage")
                    Spacer()
                    MainButton(action: {
                        self.navigateRootView()
                    }, title: "확인하러 가기")
                    Spacer()
                }
            }
        }
    }
}

extension AnswerRegisteredView {
    func navigateRootView() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = UIHostingController(rootView: MainView(window: window))
            UIView.transition(with: window,
                              duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
}

struct AnswerRegisteredView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerRegisteredView()
    }
}
