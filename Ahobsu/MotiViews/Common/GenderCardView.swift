//
//  GenderCardView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/12/21.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct GenderCardView: View {

    var isMale: Bool

    var body: some View {
        ZStack {
            MainCardView(isWithLine: false)
            VStack {
                Image(isMale ? "imgMale" : "imgFemale")
                Text(isMale ? "MAN" : "WOMAN")
                    .font(.custom("Baskerville", size: 16))
                    .foregroundColor(Color(.rosegold))
            }
        }.frame(maxWidth: 113, maxHeight: 184)
    }
}

struct GenderCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Male Card
            GenderCardView(isMale: true)
            // Female Card
            GenderCardView(isMale: false)
        }.previewLayout(.fixed(width: 133, height: 204))

    }
}
