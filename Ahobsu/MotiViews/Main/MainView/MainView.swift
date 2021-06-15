//
//  MainView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI
import Kingfisher

struct MainView: View {

    @State var window: UIWindow
    @ObservedObject var model: MainViewModel = MainViewModel()
    @ObservedObject var diaryIntent: DiaryIntent = DiaryIntent()
    @ObservedObject var albumItent: AlbumItent = AlbumItent()
    @ObservedObject var calendarManager: MonthCalendarManager = MonthCalendarManager()

    @State private var isDatePickerPresented: Bool = false

    enum Tab {
        case home
        case diary
        case album
        case profile
    }
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                home
                    .tag(Tab.home)
                    .tabItem {
                        VStack {
                            Image(selectedTab == .home ? "icMainSelected" : "icMainNormal")
                            Text("Home")
                        }
                    }
                DiaryView(diaryIntent: diaryIntent, calendarManager: calendarManager, isDatePickerPresented: $isDatePickerPresented)
                    .tag(Tab.diary)
                    .tabItem {
                        VStack {
                            Image(selectedTab == .diary ? "icDiarySelected" : "icDiaryNormal")
                            Text("Diary")
                        }
                    }
                AlbumView(intent: albumItent)
                    .tag(Tab.album)
                    .tabItem {
                        VStack {
                            Image(selectedTab == .album ? "icAlbumSelected" : "icAlbumNormal")
                            Text("Album")
                        }
                    }
                MyPageView()
                    .tag(Tab.profile)
                    .tabItem {
                        VStack {
                            Image(selectedTab == .profile ? "icProfileSelected" : "icProfileNormal")
                            Text("Mypage")
                        }
                    }
            }.accentColor(Color(.rosegold))
        }
        .bottomSheet(isPresented: $isDatePickerPresented,
                     height: 400,
                     showTopIndicator: false) {
            VStack {
                CalendarDatePicker(calendarManager: calendarManager, selection: $diaryIntent.userSelectedDate) {
                    isDatePickerPresented = false
                }
            }
        }
    }

    private var home: some View {
//        NavigationView {
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
                                                        KFImage(URL(string: cardUrl))
                                                            .placeholder( { ActivityIndicator(isAnimating: .constant(true),
                                                                                              style: .medium) } )
                                                            .setProcessor(PDFProcessor())
                                                            .resizable()
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
                    }
                    .padding([.bottom], 30)
                }
                .navigationBarTitle(Text(""), displayMode: .inline)
                .onAppear(perform: {
                    self.model.getMultipleParts()
                })
            }
//        }.statusBar(hidden: model.isStatusBarHidden)
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(window: UIWindow())
    }
}
