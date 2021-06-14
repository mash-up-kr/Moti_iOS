//
//  CalendarManager.swift
//  Sample_SwiftUI
//
//  Created by bran.new on 2021/03/30.
//

import Foundation
import UIKit
import Combine

typealias MonthsForYear = [Date: [Date]]
typealias MonthDate = [Date: [Date]]
class MonthCalendarManager: ObservableObject {

    @Published var calendar: Calendar = .current
    @Published var currentMonth: Date

    // Previous & Next Month Button Disabled
    @Published var prevMonthDisabled: Bool = false
    @Published var nextMonthDisabled: Bool = false

    private var dates: [Date] {
        didSet {
            monthsForYear = Dictionary(grouping: dates) { Calendar.current.startOfYear(for: $0) }.mapValues({ months in
                Array(Set(months.map { calendar.startOfMonth(for: $0) }))
            })
            monthDates = Dictionary(grouping: dates) { Calendar.current.startOfMonth(for: $0) }
            currentMonth = calendar.startOfMonth(for: dates.last ?? Date())
        }
    }
    @Published var monthsForYear: MonthsForYear = [:]
    @Published var monthDates: MonthDate = [:]
    var months: [Date] { Array(monthDates.keys.sorted()) }

    private var subscriptions: Set<AnyCancellable> = []

    init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dates = []

        currentMonth = Date()

        $currentMonth.map { [weak self] newCurrentMonth in
            guard let self = self else { return false }
            return newCurrentMonth.compare(self.calendar.startOfDay(for: self.months.first ?? Date())) == .orderedSame
        }
        .assign(to: \.prevMonthDisabled, on: self)
        .store(in: &subscriptions)
        $currentMonth.map { [weak self] newCurrentMonth in
            guard let self = self else { return false }
            return newCurrentMonth.compare(self.calendar.startOfDay(for: self.months.last ?? Date())) == .orderedSame
        }
        .assign(to: \.nextMonthDisabled, on: self)
        .store(in: &subscriptions)

        AhobsuProvider.getDays(completion: { rawDates in
            DispatchQueue.main.async {
                self.dates = rawDates?.data?.compactMap { formatter.date(from: $0) } ?? []
            }
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
