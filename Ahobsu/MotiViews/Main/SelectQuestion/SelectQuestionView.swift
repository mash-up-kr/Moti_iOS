//
//  SelectQuestionView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SelectQuestionView: View {
    @Binding var window: UIWindow
    @Binding var isStatusBarHidden: Bool

    @ObservedObject var model = SelectQuestionViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationMaskingView(titleItem: Text("질문 선택"), trailingItem: EmptyView()) {
            ZStack {
                BackgroundView()
                    .edgesIgnoringSafeArea([.vertical])
                
                VStack {
                    Spacer()
                    SwiftUIPagerView(spacing: 24,
                                     pageWidthCompensation: -110,
                                     index: $model.index,
                                     pages: (0..<3).map { index in
                                        QuestionCardView(id: index,
                                                         missionData: model.missions[index],
                                                         isStatusBarHidden: $isStatusBarHidden)
                        }
                    )
                    .offset(x: -50, y: 40)
                    Spacer()
                    PageControl(numberOfPages: 3, currentPage: $model.index)
                    Spacer()
                    Button(action: { self.model.getRefreshQuestion() }) {
                        Text("질문 다시받기   \(model.isRefreshAvailable ? 1 : 0) / 1")
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .foregroundColor(Color(.lightgold))
                            .padding([.vertical], 12)
                            .padding([.horizontal], 24)
                            .foregroundColor(.clear)
                            .overlay(Capsule()
                                .stroke(Color(.lightgold), lineWidth: 1)
                        )
                    }.environment(\.isEnabled, model.isRefreshAvailable)
                        .opacity(model.isRefreshAvailable ? 1 : 0.4)
                    Spacer(minLength: 32)
                }
                .onAppear {
                    if self.model.missions[0].title == "" {
                        model.getNewQuestion()
                    }
                }
            }
        }
    }
}

struct SelectQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectQuestionView(window: .constant(UIWindow()), isStatusBarHidden: .constant(false))
    }
}
