//
//  DateValidator.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/02/18.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

final class DateValidator {
    
    var maximumYear: Int?
    var monthsWith31Days: [Int] = [1, 3, 5, 7, 8, 10, 12]
    
    func validatedDateComponents(from dateComponents: DateComponents) -> DateComponents {
        guard
            let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day
        else {
            return dateComponents
        }
        var newDateComponents = dateComponents
        if month == 2 {
            if isLeapYear(year), day > 29 {
                newDateComponents.day = 29
            }
            if !isLeapYear(year), day > 28 {
                newDateComponents.day = 28
            }
            
        } else if !monthsWith31Days.contains(month), day > 30 {
            newDateComponents.day = 30
        }
        if let maximumYear = maximumYear, year > maximumYear {
            newDateComponents.year = maximumYear
        }
        return newDateComponents
    }
    
    func isLeapYear(_ year: Int) -> Bool {
        return (year % 100 != 0 && year % 4 == 0) || year % 400 == 0
    }
}
