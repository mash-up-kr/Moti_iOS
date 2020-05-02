//
//  GenderCardView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/12/21.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct GenderCardView: View {
    
    var gender: SignUp.Gender
    private var isMale: Bool {
        return gender == .male
    }
    
    var body: some View {
        ZStack {
            CardView(isWithLine: false)
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
            GenderCardView(gender: .male)
            // Female Card
            GenderCardView(gender: .female)
        }.previewLayout(.fixed(width: 133, height: 204))
        
    }
}
