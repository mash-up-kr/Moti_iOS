//
//  MainViewModel.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/01/28.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import Foundation
import SwiftUI

final class MainViewModel: ObservableObject {
    @Published private(set) var state = State.idle
    @Published var isAnswered: Bool = false
    @Published var todayCard: Answer?
    @Published var cards: [Answer?] = [nil, nil, nil, nil, nil, nil]
    @Published var isStatusBarHidden: Bool = false
    @Published var isFirstLoad = true
}


extension MainViewModel {
    enum State {
        case idle
    }

    enum Event {
        case onAppear
    }
    
    func getMultipleParts() {
        AhobsuProvider.getAnswersWeek(completion: { wrapper in
            if var answerWeek = wrapper?.data {
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = .withFullDate
                formatter.timeZone = TimeZone.current
                let dateString = formatter.string(from: Date())
                
                withAnimation {
                    if let lastCard = answerWeek.answers.last {
                        if lastCard?.date == dateString {
                            self.todayCard = lastCard
                        }
                    }
                }
                
                // nil 로 상단 뷰에서 확인
                while (answerWeek.answers.count < 6) {
                    answerWeek.answers.append(nil)
                }
                
                withAnimation {
                    self.cards = answerWeek.answers
                }
            }
        }, error: { err in
            print(err)
        }, expireTokenAction: {
            
        }, filteredStatusCode: nil)
    }
    
    func getMainFrameImageString(isTop: Bool) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: Date())
        
        var season = "spring"
        
        switch month {
        case "03", "04", "05":
            season = "spring"
            
        case "06", "07", "08":
            season = "summer"
            
        case "09", "10", "11":
            season = "authun"
            
        case "12", "01", "02":
            season = "winter"
        default:
            break
        }
        
        return "img_main_frame_\(season)_\(isTop ? "top" : "bottom")"
    }
}
