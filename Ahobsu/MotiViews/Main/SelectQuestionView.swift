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
    @State var missions = [MissionData(id: 1, title: "", isContent: 1, isImage: 1),
                           MissionData(id: 1, title: "", isContent: 1, isImage: 1),
                           MissionData(id: 1, title: "", isContent: 1, isImage: 1),
                           MissionData(id: 1, title: "", isContent: 1, isImage: 1)]
    @State var refreshAvailable = true

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image("icArrowLeft") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color(.rosegold))
        }
        }
    }

    var body: some View {
            ZStack {
                BackgroundView()
                    .edgesIgnoringSafeArea([.vertical])

                VStack {
                    Spacer()
                    SwiftUIPagerView(index: $index, pages: (0..<3).map { index in QuestionCardView(id: index, missionData: missions[index]) })
                        .frame(height: 420, alignment: .center)
                    Spacer().frame(height: 10)
                    PageControl(numberOfPages: 3, currentPage: $index)
                    Spacer().frame(minHeight: 35, idealHeight: 50, maxHeight: 60)
                    Button(action: getNewQuestion) {
                        Text("질문 다시받기   \(refreshAvailable ? 0 : 1)/1")
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
                    if self.missions.count == 4 {
                        self.getNewQuestion()
                    }
                }
            }
            .navigationBarItems(leading: btnBack)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(
                Text("질문 선택")
                    .font(.system(size: 16, weight: .regular, design: .default)),
                displayMode: .inline
            )
                .background(NavigationConfigurator { navConfig in
                    navConfig.navigationBar.backIndicatorTransitionMaskImage = UIImage()
                    navConfig.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
                    navConfig.navigationBar.shadowImage = UIImage()
                    navConfig.navigationBar.isTranslucent = true
                    navConfig.navigationBar.backgroundColor = .clear
                    navConfig.navigationBar.titleTextAttributes = [
                        .foregroundColor: UIColor.rosegold
                    ]

                    }
        )
    }

    private func getNewQuestion() {
        AhobsuProvider.getMission(completion: { response in
            if let data = try? response.map(Mission.self).data {
                print(data.missions)
                self.missions = data.missions
                self.refreshAvailable = data.refresh
            }
            
        }) { err in
            print(err)
        }
    }
}

struct SelectQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectQuestionView(currentPage: .constant(0), isNavigationBarHidden: .constant(false))
    }
}
