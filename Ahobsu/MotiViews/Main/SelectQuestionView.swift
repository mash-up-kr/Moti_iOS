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
    @Binding var currentPage: Int
    @Binding var isNavigationBarHidden: Bool
    @State var selectQuestionActive: Bool = true

    @State var index: Int = 0
    var emptyMissions: [MissionData] {
        return [MissionData(id: 1, title: "", isContent: false, isImage: false),
                MissionData(id: 1, title: "", isContent: false, isImage: false),
                MissionData(id: 1, title: "", isContent: false, isImage: false),
                MissionData(id: 1, title: "", isContent: false, isImage: false)]
    }
    @State var missions = [MissionData(id: 1, title: "", isContent: false, isImage: false),
                           MissionData(id: 1, title: "", isContent: false, isImage: false),
                           MissionData(id: 1, title: "", isContent: false, isImage: false),
                           MissionData(id: 1, title: "", isContent: false, isImage: false)]
    @State var refreshAvailable = true

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
            ZStack {
                BackgroundView()
                    .edgesIgnoringSafeArea([.vertical])

                VStack {
                    Spacer()
                    SwiftUIPagerView(index: $index, pages: (0..<3).map { index in
                        QuestionCardView(id: index,
                                         missionData: missions[index],
                                         selectQuestionActive: $selectQuestionActive) })
                        .frame(height: 420, alignment: .center)
                    Spacer().frame(height: 10)
                    PageControl(numberOfPages: 3, currentPage: $index)
                    Spacer().frame(minHeight: 35, idealHeight: 50, maxHeight: 60)
                    Button(action: {self.selectQuestionActive = false}) {
                        Text("질문 다시받기   \(refreshAvailable ? 0 : 1)/1")
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .foregroundColor(Color(.lightgold))
                            .padding([.vertical], 12)
                            .padding([.horizontal], 24)
                            .foregroundColor(.clear)
                            .overlay(Capsule()
                                .stroke(Color(.lightgold), lineWidth: 1)
                        )
                    }.environment(\.isEnabled, !(missions.first?.title.isEmpty ?? true))
                        .opacity(!(missions.first?.title.isEmpty ?? true) ? 1 : 0.4)
                    Spacer().frame(height: 32)
                }
                .onAppear {
                    self.isNavigationBarHidden = false
                    if self.missions.count == 4 {
                        self.getNewQuestion()
                    }
                    if self.selectQuestionActive == false {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("질문 선택")
    }

    private func getNewQuestion() {
        self.missions = emptyMissions
        AhobsuProvider.getMission(completion: { wrapper in
            if let mission = wrapper?.model {
                print(mission.missions)
                withAnimation(.easeOut) {
                    self.missions = mission.missions
                    self.refreshAvailable = mission.refresh
                }
            }
        }, error: { err in
            print(err)
        }, expireTokenAction: {
            /* 토큰 만료 시 */
            self.window.rootViewController = UIHostingController(rootView: SignInView(window: self.window))
        }, filteredStatusCode: nil)
    }
}

struct SelectQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectQuestionView(window: .constant(UIWindow()), currentPage: .constant(0), isNavigationBarHidden: .constant(false))
    }
}
