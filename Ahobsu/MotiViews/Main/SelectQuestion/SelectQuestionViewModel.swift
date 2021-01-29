//
//  SelectQuestionViewModel.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/01/30.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import Foundation
import SwiftUI

final class SelectQuestionViewModel: ObservableObject {
    let emptyMissions: [Mission] = [Mission(id: 1, title: "", isContent: false, isImage: false),
                                    Mission(id: 1, title: "", isContent: false, isImage: false),
                                    Mission(id: 1, title: "", isContent: false, isImage: false)]
    
    @Published var missions = [Mission(id: 1, title: "", isContent: false, isImage: false),
                           Mission(id: 1, title: "", isContent: false, isImage: false),
                           Mission(id: 1, title: "", isContent: false, isImage: false)]
    @Published var index: Int = 0
    @Published var isRefreshAvailable = false
    
    var expireTokenAction: (() -> Void)?
}

extension SelectQuestionViewModel {
    func getRefreshQuestion() {
        missions = emptyMissions
        AhobsuProvider.refreshTodayMission(completion: { (wrapper) in
            if let mission = wrapper?.data {
                // print(mission.missions)
                withAnimation(.easeOut) { [weak self] in
                    guard let self = self else { return }
                    self.missions = mission.missions
                    self.isRefreshAvailable = mission.refresh
                }
            }
        }, error: { (error) in
            // print(error)
        }, expireTokenAction: {
//            self.window.rootViewController = UIHostingController(rootView: SignInView(window: self.window))
        }, filteredStatusCode: nil)
    }
    
    func getNewQuestion() {
        missions = emptyMissions
        AhobsuProvider.getTodayMission(completion: { wrapper in
            if let mission = wrapper?.data {
                withAnimation(.easeOut) { [weak self] in
                    guard let self = self else { return }
                    self.missions = mission.missions
                    self.isRefreshAvailable = mission.refresh
                }
            }
        }, error: { err in
            // print(err)
        }, expireTokenAction: {
            /* 토큰 만료 시 */
//            self.window.rootViewController = UIHostingController(rootView: SignInView(window: self.window))
        }, filteredStatusCode: nil)
    }
}

