//
//  CalendarPicker.swift
//  Sample_SwiftUI
//
//  Created by bran.new on 2021/03/30.
//

import SwiftUI

struct CalendarDatePicker: View {

    @frozen enum Style {
        case calendar
        case datePicker

        mutating func toggle() {
            withAnimation {
                self = self == .calendar ? .datePicker : .calendar
            }
        }
    }

    @Environment(\.calendarLayout) var layout: CalendarLayout
    @ObservedObject var calendarManager: MonthCalendarManager
    @Binding var selection: Date
    var action: (() -> Void)?
    @State private var style: Style = .calendar

    var title: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        return formatter.string(from: calendarManager.currentMonth)
    }

    init(calendarManager: MonthCalendarManager, selection: Binding<Date>, action: (() -> Void)?) {
        self.calendarManager = calendarManager
        self._selection = selection
        self.action = action
    }

    public var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Spacer()
                    if style == .calendar {
                        Button {
                            calendarManager.previousMonth()
                        } label: {
                            Image("icArrowLeft")
                                .opacity(calendarManager.prevMonthDisabled ? 0.5 : 1)
                        }.disabled(calendarManager.prevMonthDisabled)
                    }
                    Spacer()
                    Button {
                        withAnimation { 
                            style.toggle()
                        }
                    } label: {
                        HStack {
                            Text(title)
                            Image("icCalenderArrow")
                                .rotationEffect(style == .calendar ? Angle.degrees(0) : Angle.degrees(180))
                        }.foregroundColor(Color(.rosegold))
                    }
                    Spacer()
                    if style == .calendar {
                        Button {
                            calendarManager.nextMonth()
                        } label: {
                            Image("icArrowRight")
                                .opacity(calendarManager.nextMonthDisabled ? 0.5 : 1)
                        }.disabled(calendarManager.nextMonthDisabled)
                    }
                    Spacer()
                }
                if style == .calendar {
                    self.content(geometry: geometry)
                } else {
                    VStack {
                        CalendarMonthPicker(calendarManager: calendarManager,
                                            selection: $calendarManager.currentMonth,
                                            cancelAction: {
                                                style.toggle()
                                            },
                                            okAction: {
                                                style.toggle()
                                            })
                    }
                }
            }
        }.onChange(of: selection) { newDate in
            action?()
        }
    }

    private func content(geometry: GeometryProxy) -> some View {
        monthsList
            .calendarLayout(monthWidth: geometry.size.width)
    }

    private var monthsList: some View {
        if calendarManager.months.isEmpty {
            return AnyView(EmptyView())
        } else {
            return AnyView(
                TabView(selection: $calendarManager.currentMonth) {
                    ForEach(calendarManager.months, id: \.self) { date in
                        MonthView(calendarManager: calendarManager, selection: _selection, month: date)
                            .tag(date)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            )
        }
    }
}
