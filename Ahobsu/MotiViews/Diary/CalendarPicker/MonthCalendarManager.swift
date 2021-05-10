//
//  CalendarManager.swift
//  Sample_SwiftUI
//
//  Created by bran.new on 2021/03/30.
//

import Foundation
import UIKit
import Combine

typealias MonthDate = [Date: [Date]]
class MonthCalendarManager: ObservableObject {

    @Published var calendar: Calendar = .current
    @Published var currentMonth: Date

    private var dates: [Date] {
        didSet {
            monthDates = Dictionary(grouping: dates) { Calendar.current.startOfMonth(for: $0) }
            currentMonth = calendar.startOfMonth(for: dates.last ?? Date())
        }
    }
    @Published var monthDates: MonthDate = [:]
    var months: [Date] { Array(monthDates.keys.sorted()) }

    private var subscriptions: Set<AnyCancellable> = []

    init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dates = []

        currentMonth = Date()

//        $monthDates.sink { [weak self] (newDate) in
//            guard let self = self else { return }
//            if self.months.first == newDate {
//                self.loadPreviousYear()
//            }
//        }

//        $currentMonth.sink { [weak self] (newDate) in
//            guard let self = self else { return }
//            if self.months.first == newDate {
//                self.loadPreviousYear()
//            }
////            if Calendar.current.startOfMonth(for: self.currentMonth)
////                != Calendar.current.startOfMonth(for: self.today) {
////                self.months = [newDate.previousMonth, newDate, newDate.nextMonth]
////            }  else {
////                self.months = [newDate.previousMonth, newDate]
////            }
//        }.store(in: &subscriptions)

        AhobsuProvider.getDays(completion: { rawDates in
            DispatchQueue.main.async {
                self.dates = rawDates?.data?.compactMap { formatter.date(from: $0) } ?? []
            }

            print(self.dates)
        }, error: { error in

        }, expireTokenAction: {

        }, filteredStatusCode: nil)
    }

    func setup() {

    }

    func backgroundColorOpacity(for date: Date) -> CGFloat {
        return 1
    }

    func canSelectDate(for date: Date) -> Bool {
        return dates.contains(date)
    }
}

// MARK: - Previous / Next Month
extension MonthCalendarManager {
    func previousMonth() {
        if let index = months.firstIndex(of: currentMonth),
           let previousMonth = months[safe: Int(index) - 1] {
            currentMonth = previousMonth
        }
    }
    func nextMonth() {
        if let index = months.firstIndex(of: currentMonth),
           let nextMonth = months[safe: Int(index) + 1] {
            currentMonth = nextMonth
        }
    }
}

// MARK: - Previous / Next Month
extension MonthCalendarManager {
    func loadPreviousYear() {
        let previousYear = calendar.date(byAdding: .year, value: -1, to: currentMonth) ?? currentMonth
        let previousYearStartDay = calendar.startOfYear(for: previousYear)
        let newMonths = calendar.dates(inside: DateInterval(start: previousYearStartDay, end: currentMonth.previousMonth),
                                       matching: .firstDayOfEveryMonth)
//        months.insert(contentsOf: newMonths, at: 0)
        print(newMonths)
//        months = newMonths
        
    }
}
