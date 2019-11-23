//
//  MotiView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct MotiView: View {
    let color: Color

    var body: some View {
        GeometryReader { geometry in
            Circle()
                .foregroundColor(.clear)
                .background(Rectangle()
                    .fill(RadialGradient(gradient: Gradient(colors: [self.color, .white]),
                                         center: .center,
                                         startRadius: 2,
                                         endRadius: geometry.size.width * 0.85))
                    .frame(width: geometry.size.width * 1.5, height: geometry.size.height * 1.5, alignment: .center)
                    .offset(x: geometry.size.width / 4, y: 0)
            )
                .clipShape(Circle())
        }
    }
}

struct MotiView_Previews: PreviewProvider {
    static var previews: some View {
        MotiView(color: .red)
    }
}
