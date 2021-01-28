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
    @Binding var isStatusBarHidden: Bool
    
    @State var index: Int = 0
    var emptyMissions: [Mission] {
        return [Mission(id: 1, title: "", isContent: false, isImage: false),
                Mission(id: 1, title: "", isContent: false, isImage: false),
                Mission(id: 1, title: "", isContent: false, isImage: false),
                Mission(id: 1, title: "", isContent: false, isImage: false)]
    }
    @State var missions = [Mission(id: 1, title: "", isContent: false, isImage: false),
                           Mission(id: 1, title: "", isContent: false, isImage: false),
                           Mission(id: 1, title: "", isContent: false, isImage: false),
                           Mission(id: 1, title: "", isContent: false, isImage: false)]
    @State var refreshAvailable = false
    
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
                                     index: $index,
                                     pages: (0..<3).map { index in
                                        QuestionCardView(id: index,
                                                         missionData: missions[index],
                                                         isStatusBarHidden: $isStatusBarHidden)
                        }
                    )
                    .offset(x: -50, y: 40)
                    Spacer()
                    PageControl(numberOfPages: 3, currentPage: $index)
                    Spacer()
                    Button(action: { self.getRefreshQuestion() }) {
                        Text("질문 다시받기   \(refreshAvailable ? 1 : 0) / 1")
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .foregroundColor(Color(.lightgold))
                            .padding([.vertical], 12)
                            .padding([.horizontal], 24)
                            .foregroundColor(.clear)
                            .overlay(Capsule()
                                .stroke(Color(.lightgold), lineWidth: 1)
                        )
                    }.environment(\.isEnabled, refreshAvailable)
                        .opacity(refreshAvailable ? 1 : 0.4)
                    Spacer(minLength: 32)
                }
                .onAppear {
                    if self.missions.count == 4 {
                        self.getNewQuestion()
                    }
                }
            }
        }
    }
    
    private func getRefreshQuestion() {
        self.missions = emptyMissions
        AhobsuProvider.refreshTodayMission(completion: { (wrapper) in
            if let mission = wrapper?.data {
                // print(mission.missions)
                withAnimation(.easeOut) {
                    self.missions = mission.missions
                    self.refreshAvailable = mission.refresh
                }
            }
        }, error: { (error) in
            // print(error)
        }, expireTokenAction: {
            self.window.rootViewController = UIHostingController(rootView: SignInView(window: self.window))
        }, filteredStatusCode: nil)
    }
    
    private func getNewQuestion() {
        self.missions = emptyMissions
        AhobsuProvider.getTodayMission(completion: { wrapper in
            if let mission = wrapper?.data {
                withAnimation(.easeOut) {
                    self.missions = mission.missions
                    self.refreshAvailable = mission.refresh
                }
            }
        }, error: { err in
            // print(err)
        }, expireTokenAction: {
            /* 토큰 만료 시 */
            self.window.rootViewController = UIHostingController(rootView: SignInView(window: self.window))
        }, filteredStatusCode: nil)
    }
}

struct SelectQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectQuestionView(window: .constant(UIWindow()), currentPage: .constant(0), isStatusBarHidden: .constant(false))
    }
}
