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

    let weekColors: [WeekColor] = [
        WeekColor(week: "MON", color: Color(red: 255/255, green: 237/255, blue: 143/255)),
        WeekColor(week: "TUE", color: Color(red: 185/255, green: 143/255, blue: 255/255)),
        WeekColor(week: "WED", color: Color(red: 143/255, green: 214/255, blue: 255/255)),
        WeekColor(week: "THU", color: Color(red: 147/255, green: 255/255, blue: 143/255)),
        WeekColor(week: "FRI", color: Color(red: 241/255, green: 255/255, blue: 143/255)),
        WeekColor(week: "SAT", color: Color(red: 143/255, green: 164/255, blue: 255/255)),
        WeekColor(week: "SUN", color: Color(red: 173/255, green: 173/255, blue: 173/255))
    ]

    struct WeekColor: Identifiable {
        var id = UUID()

        let week: String
        let color: Color
    }

    var body: some View {
        HStack {
//            ForEach(weekColors, id: \.self) { result in
//                WeekDayCellView(weekDay: result.week, color: result.color)
//            }
            ForEach(0..<7) { index in
                WeekDayCellView(weekDay: self.weekColors[index].week, color: self.weekColors[index].color)
            }
        }
    }
}

struct DayWeekView_Previews: PreviewProvider {
    static var previews: some View {
        DayWeekView()
    }
}
