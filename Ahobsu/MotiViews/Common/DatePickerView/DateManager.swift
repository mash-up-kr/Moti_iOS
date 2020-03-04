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
        var dateComponenets = DateComponents()
        dateComponenets.year = year
        dateComponenets.month = month
        dateComponenets.day = day
        let newDateComponents = dateValidator.validatedDateComponents(from: dateComponenets)
        if let newDate = newDateComponents.date {
            validatedDate = newDate
        }
    }
}
