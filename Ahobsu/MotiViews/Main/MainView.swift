//
//  MainView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

extension String {
    static func toMainDateString(from date: Date) -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "YYYY. MM. dd"
        
        let returnStr = format.string(from: date)
        
        return returnStr
    }
}

struct MainView: View {
    @State var window: UIWindow
    @State var isAnswered: Bool = false
    @State var todayCard: Answer?
    @State var cards: [Answer?] = [nil, nil, nil, nil, nil, nil]
    
    var body: some View {
        NavigationView {
            NavigationMaskingView(isRoot: true,
                                  titleItem: DayWeekView(isFills: cards.map { $0 != nil }).frame(height: 72, alignment: .center),
                                  trailingItem: EmptyView())
            {
                ZStack {
                    BackgroundView()
                        .edgesIgnoringSafeArea([.vertical])
                    VStack {
                        
                        Spacer()
                        if todayCard != nil {
                            NavigationLink(destination: AnswerCompleteView(cards))
                            {
                                MainCardView(isWithLine: !isAnswered)
                                    .aspectRatio(0.62, contentMode: .fit)
                                    .padding([.horizontal], 59)
                                    .overlay(
                                        ZStack {
                                            ForEach(cards.compactMap { $0?.cardUrl },
                                                    id: \.self,
                                                    content: { (cardUrl) in
                                                        
                                                        ImageView(withURL: cardUrl)
                                                            .aspectRatio(0.62, contentMode: .fit)
                                                            .padding(20)
                                            })
                                        }
                                )
                            }.buttonStyle(PlainButtonStyle())
                        } else {
                            NavigationLink(destination: SelectQuestionView(window: $window,
                                                                           currentPage: .constant(0)))
                            {
                                MainCardView(isWithLine: !isAnswered)
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
                    self.getTodayData()
                    self.getWeeksData()
                })
            }
        }
    }
    
    func getTodayData() {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFullDate
        formatter.timeZone = TimeZone.current
        let dateString = formatter.string(from: Date())
        AhobsuProvider.getAnswer(missionDate: dateString, completion: { wrapper in
            if let answer = wrapper?.data {
                withAnimation(.easeOut) {
                    self.todayCard = answer
                }
            }
        }, error: { err in
            // print(err)
        }, expireTokenAction: {
            
        }, filteredStatusCode: nil)
    }
    
    func getWeeksData() {
        AhobsuProvider.getAnswersWeek(completion: { wrapper in
            if var answerWeek = wrapper?.data {
                while (answerWeek.answers.count < 6) {
                    answerWeek.answers.append(nil)
                }
                
                withAnimation {
                    self.cards = answerWeek.answers
                }
            }
        }, error: { err in
            print(err)
        }, expireTokenAction: {
            
        }, filteredStatusCode: nil)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(window: UIWindow())
    }
}
