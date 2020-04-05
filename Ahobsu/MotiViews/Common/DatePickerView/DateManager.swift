//
//  DateManager.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/02/18.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class DateManager: ObservableObject {
    
    private var dateValidator = DateValidator()
    
    init(date: Binding<Date>) {
        year = Calendar.current.component(.year, from: date.wrappedValue)
        month = Calendar.current.component(.month, from: date.wrappedValue)
        day = Calendar.current.component(.day, from: date.wrappedValue)
        _date = date
    }
    
    @Binding var date: Date
    
    @Published var year: Int {
        didSet {
            makeNewValidatedDate()
        }
    }
    @Published var month: Int {
        didSet {
            makeNewValidatedDate()
        }
    }
    @Published var day: Int {
        didSet {
            makeNewValidatedDate()
        }
    }
    private func makeNewValidatedDate() {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let suggestedDateComponents = dateValidator.validatedDateComponents(from: dateComponents)
        if let suggedstedDay = suggestedDateComponents.day,
            suggedstedDay != day {
            day = suggedstedDay
        }
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFullDate
        if let suggestedDate = formatter.date(from: "\(suggestedDateComponents.year!)-\(suggestedDateComponents.month!)-\(suggestedDateComponents.day!)") {
            date = suggestedDate
        }
    }
}
