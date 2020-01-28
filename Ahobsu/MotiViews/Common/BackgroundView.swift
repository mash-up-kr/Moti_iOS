//
//  BackgroundView.swift
//  Ahobsu
//
//  Created by admin on 2019/12/21.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct BackgroundView: View {

    @State var colorType: ColorType = .black

    var body: some View {
        VStack {
            colorType.extractLinearGradient()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

extension BackgroundView {
    enum ColorType {
        case black

        func extractLinearGradient() -> LinearGradient {
            switch self {
            case .black:
                return LinearGradient(gradient: Gradient(
                    colors: [Color(UIColor.init(red: 26/255,
                                                green: 22/255,
                                                blue: 22/255,
                                                alpha: 1.0)),
                             Color.black]),
                   startPoint: .top,
                   endPoint: .bottom
                )
            }
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
