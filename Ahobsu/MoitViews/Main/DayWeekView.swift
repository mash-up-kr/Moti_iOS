//
//  DayWeekView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct DayWeekView: View {

    let weeks: [String] = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]

//    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .pink, .purple]

    var body: some View {
        HStack {
            ForEach(weeks, id: \.self) {
                WeekDayCellView(weekDay: $0, color: .gray)
            }
        }
    }
}

struct DayWeekView_Previews: PreviewProvider {
    static var previews: some View {
        DayWeekView()
    }
}
