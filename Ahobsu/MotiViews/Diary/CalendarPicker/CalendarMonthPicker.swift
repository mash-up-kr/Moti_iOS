//
//  CalendarMonthPicker.swift
//  Ahobsu
//
//  Created by bran.new on 2021/05/16.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import SwiftUI
import Combine

struct CalendarMonthPicker: View {

    @ObservedObject var viewModel: ViewModel
    @Binding var selection: Date
    var cancelAction: (() -> Void)
    var okAction: (() -> Void)

    init(calendarManager: MonthCalendarManager,
         selection: Binding<Date>,
         cancelAction: @escaping (() -> Void),
         okAction: @escaping (() -> Void)) {
        self.viewModel = ViewModel(calendarManager: calendarManager)
        self._selection = selection
        self.cancelAction = cancelAction
        self.okAction = okAction
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    WheelView(selectedItem: $viewModel.year, items: viewModel.years)
                        .frame(width: geometry.size.width / 2, height: 44 * 3)
                    WheelView(selectedItem: $viewModel.month, items: viewModel.months)
                        .frame(width: geometry.size.width / 2, height: 44 * 3)
                }.frame(maxWidth: .infinity, minHeight: 158)
                HStack {
                    Spacer()
                    Button("취소", action: cancelAction)
                    Spacer()
                    Spacer()
                    Button("확인") {
                        let dateComponents = DateComponents(year: viewModel.year, month: viewModel.month, day: 1)
                        if let newDate = Calendar.current.date(from: dateComponents) {
                            selection = newDate
                        }
                        okAction()
                    }
                    Spacer()
                }.foregroundColor(Color(.rosegold))
            }.frame(maxWidth: .infinity)
        }.padding(20)
    }
}

extension CalendarMonthPicker {

    final class ViewModel: ObservableObject {

        var calendarManager: MonthCalendarManager

        private var subscriptions: Set<AnyCancellable> = []

        init(calendarManager: MonthCalendarManager) {
            self.calendarManager = calendarManager

            let year = calendarManager.calendar.component(.year, from: calendarManager.currentMonth)
            self.year = year
            if let yearDate = calendarManager.calendar.date(from: DateComponents(year: year)),
               let monthDate = calendarManager.monthsForYear[yearDate] {
                months = monthDate.map { calendarManager.calendar.component(.month, from: $0) }.sorted()
            } else {
                months = []
            }
            month = calendarManager.calendar.component(.month, from: calendarManager.currentMonth)

            calendarManager.$monthsForYear.sink { [weak self] monthsForYear in
                guard let self = self else { return }
                self.years = monthsForYear.keys.sorted().map { calendarManager.calendar.component(.year, from: $0) }
            }.store(in: &subscriptions)
        }
        
        @Published var years: [Int] = []
        @Published var year: Int {
            willSet {
                if let yearDate = calendarManager.calendar.date(from: DateComponents(year: newValue)),
                   let monthDate = calendarManager.monthsForYear[yearDate] {
                    months = monthDate.map { calendarManager.calendar.component(.month, from: $0) }.sorted()
                    month = months.last ?? month
                }
            }
        }
        @Published var months: [Int]
        @Published var month: Int
    }
}
