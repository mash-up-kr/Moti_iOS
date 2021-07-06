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
                     contentBackgroundColor: Color(red: 0.051, green: 0.043, blue: 0.043),
                     topBarBackgroundColor: Color(red: 0.051, green: 0.043, blue: 0.043),
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
//            NavigationMaskingView(isRoot: true,
//                                  titleItem: EmptyView(),
//                                  trailingItem: EmptyView())
//            {
                ZStack {
                    BackgroundView()
                        .edgesIgnoringSafeArea([.vertical])
                    
                    VStack {
                        Spacer()
                        if model.todayCard != nil {
                            NavigationLink(destination: AnswerCompleteView(model.cards)) {
                                VStack(spacing: 0) {
                                    Image(model.getMainFrameImageString(isTop: true))
                                    ZStack {
                                        Image(model.getMainFrameImageString(isTop: false))
                                        VStack(spacing: 0) {
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
                                            .padding(.horizontal, 120)
                                            Spacer()
                                        }
                                    }
                                }
//                                CardView(innerLine: !model.isAnswered)
//                                    .aspectRatio(257.0 / 439.0, contentMode: .fit)
//                                    .padding([.horizontal], 59.0)
//                                    .overlay(
//
//                                )
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
                    
                    VStack {
                        Spacer()
                            .frame(height: 40, alignment: .bottom)
                        DayWeekView(isFills: model.cards.map { $0 != nil }).frame(height: 72, alignment: .bottom)
                        Spacer()
                    }
                    .edgesIgnoringSafeArea([.vertical])
                }
                .onAppear(perform: {
                    self.model.getMultipleParts()
                })
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(window: UIWindow())
    }
}
