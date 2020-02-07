//
//  MainNavigationBar.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/02/06.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation
import SwiftUI

struct MainNavigationBar<Left: View, Center: View, Right: View>: View {
    
    let left: () -> Left
    let center: () -> Center
    let right: () -> Right
    
    init(@ViewBuilder left: @escaping () -> Left,
                      @ViewBuilder center: @escaping () -> Center,
                                   @ViewBuilder right: @escaping () -> Right) {
        self.left = left
        self.center = center
        self.right = right
    }
    var body: some View {
        ZStack {
            HStack {
                left()
                Spacer()
            }
            center()
            HStack {
                Spacer()
                right()
            }
        }
    }
}
