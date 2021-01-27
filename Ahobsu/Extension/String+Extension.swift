//
//  String+Extension.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/01/28.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import Foundation

extension String {
    static func toMainDateString(from date: Date) -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "YYYY. MM. dd"
        
        let returnStr = format.string(from: date)
        
        return returnStr
    }
}
