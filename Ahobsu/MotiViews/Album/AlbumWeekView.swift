//
//  AlbumWeekView.swift
//  Ahobsu
//
//  Created by 김선재 on 13/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI
import Kingfisher

struct AlbumWeekView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var answers: [Answer?]
    @State var navigationTitle: String
    
    var body: some View {
        NavigationMaskingView(titleItem: Text(navigationTitle),
                              trailingItem: EmptyView()) {
            DayWeekView(isFills: answers.map { $0 != nil })
                .frame(height: 72, alignment: .center)
            ZStack {
                NavigationLink(destination: AnswerCompleteView(models: answers.compactMap({ $0 }))) {
                    CardView(innerLine: true)
                        .aspectRatio(257.0 / 439.0, contentMode: .fit)
                        .padding([.horizontal], 59)
                        .overlay(
                            ZStack {
                                ForEach(answers.compactMap { $0?.file.cardUrl },
                                        id: \.self,
                                        content: { (cardUrl) in
                                            KFImage.url(URL(string: cardUrl) ?? URL(string: ""))
                                                .placeholder( { ActivityIndicator(isAnimating: .constant(true), style: .medium) } )
                                                .setProcessor(PDFProcessor())
                                                .fade(duration: 0.25)
                                                .renderingMode(.original)
                                                .resizable()
                                                .aspectRatio(257.0 / 439.0, contentMode: .fit)
                                                .padding(10)
                                })
                            }
                    )
                }
            }.frame(maxHeight: .infinity)
        }
        .background(BackgroundView().edgesIgnoringSafeArea(.vertical))
    }
}
