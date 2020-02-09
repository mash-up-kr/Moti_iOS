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
            VStack {
                Spacer()
                Text("오늘의 미션을\n완료하였습니다!").multilineTextAlignment(.center)
                    .foregroundColor(Color(.rosegold))
                    .font(.custom("IropkeBatangM", size: 24.0))
                    .lineSpacing(10.0)
                Spacer()
                MainButton(action: {
                    self.navigateRootView()
                }, title: "메인으로 돌아가기")
                Spacer()
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
