//
//  DiarySeparator.swift
//  Ahobsu
//
//  Created by bran.new on 2021/03/24.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import SwiftUI

struct DiarySeparator: View {

    var title: String

    var body: some View {
        HStack {
            VStack {
                Divider()
                    .foregroundColor(Color(.pinkishTan))
            }
            Spacer(minLength: 24)
            Text(title)
                .font(.custom("IropkeBatangOTFM", size: 20.0))
                .foregroundColor(Color(UIColor.rosegold))
            Spacer(minLength: 24)
            VStack {
                Divider()
                    .foregroundColor(Color(.pinkishTan))
            }
        }.frame(height: 72)
    }
}

struct DiarySeparator_Previews: PreviewProvider {
    static var previews: some View {
        DiarySeparator(title: "2020. 12")
    }
}
