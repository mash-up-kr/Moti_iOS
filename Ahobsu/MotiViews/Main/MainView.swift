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
    @State var isNavigationBarHidden: Bool = true
    @State var isAnswered: Bool = false
    @State var todayCard: Answer?
    @State var cards: [Answer?] = [nil, nil, nil, nil, nil, nil, nil]

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                    .edgesIgnoringSafeArea([.vertical])
                VStack {
                    DayWeekView(isFills: cards.map { $0 != nil })
                        .frame(height: 72, alignment: .center)
                        .padding([.horizontal], 15)
                    Spacer()
                    NavigationLink(destination: SelectQuestionView(window: $window,
                                                                   currentPage: .constant(0),
                                                                   isNavigationBarHidden: self.$isNavigationBarHidden)) {
                        MainCardView(isWithLine: !isAnswered)
                            .aspectRatio(0.62, contentMode: .fit)
                            .padding([.horizontal], 59)
                            .overlay(
                                ZStack {
                                    if todayCard != nil {
                                        ZStack {
                                            ForEach(cards.compactMap { $0?.cardUrl },
                                                    id: \.self,
                                                    content: { (cardUrl) in
                                                ImageView(withURL: cardUrl)
                                            })
                                        }
                                    } else {
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

                                }
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .environment(\.isEnabled, todayCard == nil)

                    Spacer()
                    HStack {
                        Button(action: goToCalendar) {
                            Image("icAlbumNormal")
                                .foregroundColor(Color(.rosegold))
                                .frame(width: 48, height: 48, alignment: .center)
                        }

                        Spacer()

                        Text("Nov. 2nd week")
                            .foregroundColor(Color(.rosegold))
                            .font(.system(size: 20, weight: .regular, design: .default))

                        Spacer()
                        NavigationLink(destination: MyPageView(isNavigationBarHidden: self.$isNavigationBarHidden)) {
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
            .navigationBarHidden(isNavigationBarHidden)
            .onAppear(perform: {
                self.isNavigationBarHidden = true
                self.getTodayData()
                self.getWeeksData()
            })
        }
    }
    
    func getTodayData() {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFullDate
        let dateString = formatter.string(from: Date())
        AhobsuProvider.getAnswer(missionDate: dateString, completion: { wrapper in
            if let answer = wrapper?.model {
                withAnimation(.easeOut) {
                    self.todayCard = answer
                }
            }
        }, error: { err in
            print(err)
        }, expireTokenAction: {
            
        }, filteredStatusCode: nil)
    }
    
    func goToCalendar() {
        
    }
    
    func getWeeksData() {
        AhobsuProvider.getAnswersWeek(completion: { wrapper in
            if let answerWeek = wrapper?.model {
                self.cards = answerWeek.answers
            } else {
                
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
