//
//  CalendarLayout.swift
//  Sample_SwiftUI
//
//  Created by bran.new on 2021/03/30.
//

import Foundation
import SwiftUI

struct CalendarLayout {

    var primaryColor: Color = .pink

    private var minimumDayWidth: CGFloat { 18 }
    var dayWidth: CGFloat { minimumDayWidth }
    var dayHorizontalSpacing: CGFloat { (monthWidth - (minimumDayWidth * 7)) / 8 }
    var dayVerticalSpacing: CGFloat { 0 }
    var monthWidth: CGFloat

    init(monthWidth: CGFloat) {
        self.monthWidth = monthWidth
    }
}

private struct CalendarLayoutEnvironmentKey: EnvironmentKey {
    static var defaultValue: CalendarLayout = CalendarLayout(monthWidth: 320)
}

extension EnvironmentValues {
    var calendarLayout: CalendarLayout {
        get { self[CalendarLayoutEnvironmentKey.self] }
        set { self[CalendarLayoutEnvironmentKey.self] = newValue }
    }
}

extension View {
    func calendarLayout(monthWidth: CGFloat) -> some View {
        environment(\.calendarLayout, CalendarLayout(monthWidth: monthWidth))
    }
}
