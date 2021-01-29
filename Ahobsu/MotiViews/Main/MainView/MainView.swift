//
//  MainView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var window: UIWindow
    @ObservedObject var model: MainViewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            NavigationMaskingView(isRoot: true,
                                  titleItem: DayWeekView(isFills: model.cards.map { $0 != nil }).frame(height: 72, alignment: .center),
                                  trailingItem: EmptyView())
            {
                ZStack {
                    BackgroundView()
                        .edgesIgnoringSafeArea([.vertical])
                    VStack {
                        
                        Spacer()
                        if model.todayCard != nil {
                            NavigationLink(destination: AnswerCompleteView(model.cards))
                            {
                                CardView(innerLine: !model.isAnswered)
                                    .aspectRatio(257.0 / 439.0, contentMode: .fit)
                                    .padding([.horizontal], 59.0)
                                    .overlay(
                                        ZStack {
                                            ForEach(model.cards.compactMap { $0?.file.cardUrl },
                                                    id: \.self,
                                                    content: { (cardUrl) in
                                                        ImageView(withURL: cardUrl)
                                                            .aspectRatio(257.0 / 439.0, contentMode: .fit)
                                                            .padding(17)
                                            })
                                        }
                                )
                            }.buttonStyle(PlainButtonStyle())
                        } else {
                            NavigationLink(destination: SelectQuestionView(window: $window,
                                                                           isStatusBarHidden: $model.isStatusBarHidden))
                            {
                                CardView(innerLine: !model.isAnswered)
                                    .aspectRatio(0.62, contentMode: .fit)
                                    .padding([.horizontal], 59)
                                    .overlay(
                                        ZStack {
                                            VStack {
                                                Text("Motivation")
                                                    .font(.custom("Baskerville", size: 16.0))
                                                    .foregroundColor(Color(.rosegold))
                                                Spacer()
                                                Image("imgQuestion")
                                                Spacer()
                                                Text("Today’s\nyour\nQuestion")
                                                    .font(.custom("Baskerville", size: 16.0))
                                                    .foregroundColor(Color(.rosegold))
                                                    .multilineTextAlignment(.center)
                                            }
                                            .padding([.vertical], 32)
                                        }
                                )
                            }.buttonStyle(PlainButtonStyle())
                        }
                        Spacer()
                        HStack {
                            NavigationLink(destination: AlbumView()) {
                                Image("icAlbumNormal")
                                    .foregroundColor(Color(.rosegold))
                                    .frame(width: 48, height: 48, alignment: .center)
                            }
                            
                            Spacer()
                            
                            Text(String.toMainDateString(from: Date()))
                                .foregroundColor(Color(.rosegold))
                                .font(.custom("IropkeBatangOTFM", size: 20.0))
                                .lineSpacing(16.0)
                            
                            Spacer()
                            NavigationLink(destination: MyPageView()) {
                                Image("icProfileNormal")
                                    .foregroundColor(Color(.rosegold))
                                    .frame(width: 48, height: 48, alignment: .center)
                            }
                        }
                        .padding(.horizontal, 15)
                        .padding([.top], 11)
                    }
                    .padding([.bottom], 30)
                }
                .navigationBarTitle(Text(""), displayMode: .inline)
                .onAppear(perform: {
                    self.model.getMultipleParts()
                })
            }
        }.statusBar(hidden: model.isStatusBarHidden)
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(window: UIWindow())
    }
}
