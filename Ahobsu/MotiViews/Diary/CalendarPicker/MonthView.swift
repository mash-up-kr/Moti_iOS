//
//  MonthView.swift
//  Sample_SwiftUI
//
//  Created by bran.new on 2021/03/30.
//

import SwiftUI

struct MonthView: View {

    @ObservedObject var calendarManager: MonthCalendarManager
    @Environment(\.calendarLayout) var layout: CalendarLayout
    @Binding var selection: Date

    let month: Date

    private var weeks: [Date] {
        guard let monthInterval = calendarManager.calendar.dateInterval(of: .month, for: month) else {
            return []
        }
        return calendarManager.calendar.dates(inside: monthInterval,
                                              matching: calendarManager.calendar.firstDayOfEveryWeek)
    }

    var body: some View {
        VStack(spacing: 40) {
            weeksViewWithDaysOfWeekHeader
            Spacer()
        }
        .padding(.top, 50)
        .frame(width: layout.monthWidth, height: layout.monthHeight)
    }

}

extension String: Identifiable {
    public var id: String { self }
}

// MARL: - Sub View
private extension MonthView {

    var weeksViewWithDaysOfWeekHeader: some View {
        VStack(spacing: 32) {
            daysOfWeekHeader
            weeksViewStack
        }
    }

    var daysOfWeekHeader: some View {
        HStack(spacing: layout.dayHorizontalSpacing) {
            ForEach(calendarManager.calendar.veryShortWeekdaySymbols, id: \.self) { dayOfWeek in
                Text(dayOfWeek)
                    .font(.caption)
                    .frame(width: layout.dayWidth)
                    .foregroundColor(.gray)
            }
        }
    }

    var weeksViewStack: some View {
        VStack(spacing: layout.dayHorizontalSpacing) {
            ForEach(weeks, id: \.self) { week in
                WeekView(calendarManager: self.calendarManager, selection: $selection, week: week)
            }
        }
    }

}
