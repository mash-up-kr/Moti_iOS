//
//  Config.swift
//  Ahobsu
//
//  Created by 김선재 on 2021/08/05.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import Foundation

class InitTime {
    var hour: Int
    var minute: Int
    
    init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
}

let MISSION_INIT_TIME = InitTime(hour: 5, minute: 0)
