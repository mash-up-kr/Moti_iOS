//
//  Foundation+Extensions.swift
//  Sample_SwiftUI
//
//  Created by bran.new on 2021/03/30.
//

import Foundation

// MARK: - DateComponents
extension DateComponents {
    static var everyDay: DateComponents {
        DateComponents(hour: 0, minute: 0, second: 0)
    }

    static var firstDayOfEveryMonth: DateComponents {
        DateComponents(day: 1, hour: 0, minute: 0, second: 0)
    }

    static var firstDayOfEveryYear: DateComponents {
        DateComponents(month: 1, day: 1, hour: 0, minute: 0, second: 0)
    }
}


// MARK: - Calendar
extension Calendar {
    func dates(inside interval: DateInterval,
               matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(startingAfter: interval.start,
                       matching: components,
                       matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        return dates
    }
    func isDate(_ date1: Date, equalTo date2: Date, toGranularities components: Set<Calendar.Component>) -> Bool {
        components.reduce(into: true) { isEqual, component in
            isEqual = isEqual && isDate(date1, equalTo: date2, toGranularity: component)
        }
    }
    func endOfDay(for date: Date) -> Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return self.date(byAdding: components, to: startOfDay(for: date))!
    }
    func startOfMonth(for date: Date) -> Date {
        let components = dateComponents([.month, .year], from: date)
        return self.date(from: components)!
    }

    func startOfYear(for date: Date) -> Date {
        let components = dateComponents([.year], from: date)
        return self.date(from: components)!
    }
}

extension Calendar {
    var firstDayOfEveryWeek: DateComponents {
        DateComponents(hour: 0, minute: 0, second: 0, weekday: firstWeekday)
    }
}

extension Date {
    var previousMonth: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self) ?? self

    }
    var nextMonth: Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: self) ?? self
    }
}
