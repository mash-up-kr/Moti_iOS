//
//  WeekDayCellView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct WeekDayCellView: View {
    var weekDay: String
    var color: Color
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(weekDay)
                .font(.system(size: 13,
                              weight: .regular,
                              design: .default)
            )
            Circle()
                .foregroundColor(color)
        }
    }
}

struct WeekDayCellView_Previews: PreviewProvider {
    static var previews: some View {
        WeekDayCellView(weekDay: "MON", color: .blue)
            .previewLayout(.fixed(width: 39, height: 59))

    }
}
