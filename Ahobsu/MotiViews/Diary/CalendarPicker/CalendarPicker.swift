//
//  CalendarPicker.swift
//  Sample_SwiftUI
//
//  Created by bran.new on 2021/03/30.
//

import SwiftUI

struct CalendarPicker: View {

    @frozen enum Style {
        case calendar
        case datePicker

        mutating func toggle() {
            self = self == .calendar ? .datePicker : .calendar
        }
    }

    @Environment(\.calendarLayout) var layout: CalendarLayout
    @ObservedObject var calendarManager: MonthCalendarManager
    @State private var style: Style = .calendar

    var title: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: calendarManager.currentMonth)
    }

    init(calendarManager: MonthCalendarManager) {
        self.calendarManager = calendarManager
    }

    public var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Spacer()
                    Button {
                        calendarManager.previousMonth()
                    } label: {
                        Text("<<")
                    }
                    Spacer()
                    Button {
                        withAnimation { 
                            style.toggle()
                        }
                    } label: {
                        Text(title)
                    }
                    Spacer()
                    Button {
                        calendarManager.nextMonth()
                    } label: {
                        Text(">>")
                    }.disabled(calendarManager.calendar.startOfMonth(for: Date()) == calendarManager.currentMonth)
                    Spacer()
                }
                if style == .calendar {
                    self.content(geometry: geometry)
                } else {
                    DatePicker("", selection: .constant(Date()), in: Date()...Date())
                }
            }
        }
    }

    private func content(geometry: GeometryProxy) -> some View {
        monthsList
            .calendarLayout(monthWidth: geometry.size.width)
            .frame(height: layout.monthHeight)
    }

    private var monthsList: some View {
        if calendarManager.months.isEmpty {
            return AnyView(EmptyView())
        } else {
            return AnyView(TabView(selection: $calendarManager.currentMonth) {
                ForEach(calendarManager.months, id: \.self) { date in
                    MonthView(calendarManager: calendarManager, month: date)
                        .tag(date)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)))
//            .erased
        }

//        .erased
    }
}
