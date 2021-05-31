//
//  Array+Extension.swift
//  Ahobsu
//
//  Created by bran.new on 2021/03/24.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import Foundation

extension Array {
    var isNotEmpty: Bool { !isEmpty }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
