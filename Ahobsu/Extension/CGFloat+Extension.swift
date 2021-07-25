//
//  CGFloat+Extension.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/07/25.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import UIKit

extension CGFloat {
    static var safeAreaTop: CGFloat {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.top
    }
    
    static var safeAreaBottom: CGFloat {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.bottom
    }
}
