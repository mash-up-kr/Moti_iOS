//
//  MonthEnum.swift
//  Ahobsu
//
//  Created by admin on 07/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

enum MonthEnum: String {
    case Jan
    case Feb
    case Mar
    case Apr
    case May
    case Jun
    case Jul
    case Aug
    case Sep
    case Oct
    case Nov
    case Dec
    case None
    
    init(month: Int) {
        switch (month) {
        case 1:
            self = .Jan
            break
        case 2:
            self = .Feb
            break
        case 3:
            self = .Mar
            break
        case 4:
            self = .Apr
            break
        case 5:
            self = .May
            break
        case 6:
            self = .Jun
            break
        case 7:
            self = .Jul
            break
        case 8:
            self = .Aug
            break
        case 9:
            self = .Sep
            break
        case 10:
            self = .Oct
            break
        case 11:
            self = .Nov
            break
        case 12:
            self = .Dec
            break
        default:
            self = .None
            break
        }
    }
    
    func longMonthString() -> String {
        switch self {
        case .Jan: return "January"
        case .Feb: return "February"
        case .Mar: return "March"
        case .Apr: return "April"
        case .May: return "May"
        case .Jun: return "June"
        case .Jul: return "July"
        case .Aug: return "August"
        case .Sep: return "September"
        case .Oct: return "October"
        case .Nov: return "November"
        case .Dec: return "December"
        default: return "Error"
        }
    }
}
