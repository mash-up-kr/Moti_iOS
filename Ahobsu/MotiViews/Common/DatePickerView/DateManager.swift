//
//  DateManager.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/02/18.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation
import Combine

class DateManager: ObservableObject {
    
    private var dateValidator = DateValidator()
    
    init(date: Date) {
        validatedDate = date
        year = Calendar.current.component(.year, from: date)
        month = Calendar.current.component(.month, from: date)
        day = Calendar.current.component(.day, from: date)
    }
    
    @Published var validatedDate: Date {
        didSet {
            validatedDateDidChange.send(validatedDate)
        }
    }
    var validatedDateDidChange = PassthroughSubject<Date, Never>()
    
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
            validatedDate = suggestedDate
        }
    }
}
