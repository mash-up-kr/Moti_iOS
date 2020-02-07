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
    var isFill: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(weekDay)
                .foregroundColor(Color(.rosegold))
                .font(.system(size: 13,
                              weight: .regular,
                              design: .default)
                    
            )
            Circle()
                .foregroundColor(isFill ? Color(.rosegold) : Color(.greyishBrown))
                .frame(width: 16, height: 16, alignment: .center)
                .shadow(
                    color: isFill ? Color(.shadowpink) : Color(.greyishBrown),
                    radius: isFill ? 4 : .zero,
                    x: 0,
                    y: 0
            )
        }
    }
}

struct WeekDayCellView_Previews: PreviewProvider {
    static var previews: some View {
        WeekDayCellView(weekDay: "MON", isFill: true)
            .previewLayout(.fixed(width: 39, height: 59))
        
    }
}
