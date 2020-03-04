//
//  AlbumWeekView.swift
//  Ahobsu
//
//  Created by 김선재 on 13/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct AlbumWeekView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var answers: [Answer?]
    @State var navigationTitle: String
    @State var weekNumber: Int
    
    var body: some View {
        NavigationMaskingView(titleItem: Text(navigationTitle),
                              trailingItem: EmptyView()) {
            DayWeekView(isFills: answers.map { $0 != nil })
                .frame(height: 72, alignment: .center)
            ZStack {
                NavigationLink(destination: AnswerCompleteView(answers)) {
                    ForEach(self.answers.compactMap { $0?.file.cardUrl },
                            id: \.self,
                            content: { (cardUrl) in
                                ImageView(withURL: cardUrl)
                                    .aspectRatio(0.62, contentMode: .fit)
                                    .padding(20)
                    })
                }
            }.frame(height: 416.0)
        }
        .background(BackgroundView().edgesIgnoringSafeArea(.vertical))
    }
}
