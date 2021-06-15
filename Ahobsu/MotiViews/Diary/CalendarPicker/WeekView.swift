//
//  WeekView.swift
//  Sample_SwiftUI
//
//  Created by bran.new on 2021/03/30.
//

import SwiftUI

struct WeekView: View {

    @ObservedObject var calendarManager: MonthCalendarManager
    @Environment(\.calendarLayout) var layout: CalendarLayout
    @Binding var selection: Date

    var week: Date

    private var days: [Date] {
        guard let weekInterval = calendarManager.calendar.dateInterval(of: .weekOfYear, for: week) else { return [] }
        return calendarManager.calendar.dates(inside: weekInterval, matching: .everyDay)
    }

    var body: some View {
        LazyHStack(spacing: layout.dayHorizontalSpacing) {
            ForEach(days, id: \.self) { day in
                DayView(calendarManager: calendarManager, selection: $selection, week: week, day: day)
            }
        }
    }
}
