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

    var dayWidth: CGFloat { 18 }
    var dayHorizontalSpacing: CGFloat { (monthWidth - (dayWidth * 7)) / 8 }
    var dayVerticalSpacing: CGFloat { 12 }
    var monthWidth: CGFloat
    var monthHeight: CGFloat {
        400
//        dayWidth * 5 + dayVerticalSpacing * 4
    }
    var monthHorizontalSpacing: CGFloat = 0
    var outerHorizontalPadding: CGFloat = 0

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
