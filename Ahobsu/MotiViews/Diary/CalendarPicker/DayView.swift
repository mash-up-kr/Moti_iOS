//
//  DayView.swift
//  Sample_SwiftUI
//
//  Created by bran.new on 2021/03/30.
//

import SwiftUI

struct DayView: View {

    @ObservedObject var calendarManager: MonthCalendarManager
    @Environment(\.calendarLayout) var layout: CalendarLayout
    @Binding var selection: Date

    let week: Date
    let day: Date

    private var isDayWithinWeekMonthAndYear: Bool {
        calendarManager.calendar.isDate(week, equalTo: day, toGranularities: [.month, .year])
    }

    private var canSelectDay: Bool {
        calendarManager.canSelectDate(for: day)
    }

    private var isDaySelectableAndInRange: Bool {
        isDayWithinWeekMonthAndYear && canSelectDay
    }

    private var isToday: Bool {
        calendarManager.calendar.isDateInToday(day)
    }

    var body: some View {
        Text(numericDay)
            .font(.footnote)
            .foregroundColor(foregroundColor)
            .frame(width: layout.dayWidth, height: layout.dayWidth)
//            .clipShape(Circle())
            .opacity(opacity)
//            .overlay(isSelected ? CircularSelectionView() : nil)
            .onTapGesture {
                notifyManager()
            }
    }

    private var numericDay: String {
        String(calendarManager.calendar.component(.day, from: day))
    }

    private var foregroundColor: Color { .primary }

    private var opacity: Double {
        return isDaySelectableAndInRange ? 1 : 0.15
    }

    private func notifyManager() {
        guard canSelectDay else { return }

        if isDayWithinWeekMonthAndYear {
            selection = day
            // Haptic Feedback
            // Change Binding Day
        }
    }

}

private struct CircularSelectionView: View {

    @State private var startBounce = false

    var body: some View {
        Circle()
            .stroke(Color.primary, lineWidth: 2)
            .frame(width: radius, height: radius)
            .opacity(startBounce ? 1 : 0)
            .animation(.interpolatingSpring(stiffness: 150, damping: 10))
            .onAppear(perform: startBounceAnimation)
    }

    private var radius: CGFloat {
        let estimatedCellWidth: CGFloat = 20
        return startBounce ? estimatedCellWidth + 6 : estimatedCellWidth + 25
    }

    private func startBounceAnimation() {
        startBounce = true
    }

}
