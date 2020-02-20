//
//  OnBordingCardView.swift
//  Ahobsu
//
//  Created by 김선재 on 29/01/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct OnBordingCardView: View {
    
    var onBordingModel: OnBordingModel
    
    @State private var cardViewOpacity: Double = 0.0
    
    var spacingBodyVStack: CGFloat { 16.0 }
    
    var paddingImageTop: CGFloat { 16.0 }
    var paddingImageHorizontal: CGFloat { 20.0 }
    
    var durationCardAppearAnimation: Double { 0.5 }
    var durationCardDisapperAnimation: Double { 0.25 }
    
    var body: some View {
        VStack(alignment: .center, spacing: spacingBodyVStack) {
            Spacer()
            Text(onBordingModel.headline)
                .font(.custom("IropkeBatangOTFM", size: 20.0))
                .foregroundColor(Color.init(.lightgold))
                .lineSpacing(16.0)
                .multilineTextAlignment(.center)
            Text(onBordingModel.detail)
                .font(.custom("IropkeBatangOTFM", size: 12.0))
                .foregroundColor(Color.init(.rosegold))
                .lineSpacing(8.0)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
            Image(onBordingModel.imageName)
                .padding(.top, paddingImageTop)
                .padding(.horizontal, paddingImageHorizontal)
        }
        .opacity(cardViewOpacity)
        .onAppear() {
            withAnimation(.easeIn(duration: self.durationCardAppearAnimation)) {
                self.cardViewOpacity = 1.0
            }
        }
        .onDisappear {
            withAnimation(.easeIn(duration: self.durationCardDisapperAnimation)) {
                self.cardViewOpacity = 0.0
            }
        }
    }
}

struct OnBordingCardView_Previews: PreviewProvider {
    static var previews: some View {
        let models: [OnBordingModel] = OnBordingModel.createOnBordingModel()
        
        return Group {
            ForEach(models, id: \.self) { model in
                OnBordingCardView(onBordingModel: model)
                    .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                    .previewDisplayName("iPhone 8")
            }
        }
    }
}
