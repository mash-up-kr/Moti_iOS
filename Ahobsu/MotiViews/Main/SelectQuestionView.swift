//
//  SelectQuestionView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SelectQuestionView: View {
    @Binding var currentPage: Int
    @Binding var isNavigationBarHidden: Bool

    @State var index: Int = 0

    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea([.vertical])

            VStack {
                Spacer()
                SwiftUIPagerView(index: $index, pages: (0..<3).map { index in QuestionCardView(id: index) })
                    .frame(height: 420, alignment: .center)
                Spacer().frame(height: 10)
                PageControl(numberOfPages: 3, currentPage: $index)
                Spacer().frame(height: 35)
                Button(action: getNewQuestion) {
                    Text("질문 다시받기   0/3")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(Color(.lightgold))
                        .padding([.vertical], 12)
                        .padding([.horizontal], 24)
                        .foregroundColor(.clear)
                        .overlay(Capsule()
                            .stroke(Color(.lightgold), lineWidth: 1)
                    )
                }
                Spacer().frame(height: 32)
            }
            .onAppear {
                self.isNavigationBarHidden = false
            }
//            .onDisappear {
//                self.isNavigationBarHidden = true
//            }
        }
    }

    private func getNewQuestion() {

    }
}

struct SelectQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectQuestionView(currentPage: .constant(0), isNavigationBarHidden: .constant(false))
    }
}
