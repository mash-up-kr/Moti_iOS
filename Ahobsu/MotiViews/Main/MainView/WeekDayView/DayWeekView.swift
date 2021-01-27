//
//  DayWeekView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct DayWeekView: View {
    
    var isFills: [Bool] = [true, true, true, true, true, true]
    
    func SeqTitleFromIndex(_ seq: Int) -> String {
        switch seq {
        case 1:
            return "1st"
        case 2:
            return "2nd"
        case 3:
            return "3rd"
        default:
            return "\(seq)th"
        }
    }
    
    var body: some View {
        HStack {
            ForEach(0..<isFills.count) { index in
                Spacer()
                WeekDayCellView(title: self.SeqTitleFromIndex(index + 1),
                                isFill: self.isFills[index])
            }
            Spacer()
        }
    }
}

struct DayWeekView_Previews: PreviewProvider {
    static var previews: some View {
        DayWeekView()
    }
}
