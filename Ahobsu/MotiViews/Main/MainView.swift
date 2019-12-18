//
//  MainView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea([.vertical])
            VStack {
                DayWeekView()
                    .frame(height: 72, alignment: .center)
                    .padding([.horizontal], 15)
                Spacer()
                MainCardView()
                    .aspectRatio(0.62, contentMode: .fit)
                    .padding([.horizontal], 59)
                    .overlay(
                        VStack {
                            Text("Motivation")
                                .font(.custom("Baskerville", size: 16))
                                .foregroundColor(Color(.rosegold))
                            Spacer()
                            Image("imgQuestion")
                            Spacer()
                            Text("Today’s\nyour\nQuestion")
                                .font(.custom("Baskerville", size: 16))
                                .foregroundColor(Color(.rosegold))
                                .multilineTextAlignment(.center)
                        }
                        .padding([.vertical], 32)
                )
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

                    Button(action: goToMyPage) {
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
    }
    func goToCalendar() {

    }

    func goToMyPage() {

    }
//    @State var isNavigationBarHidden: Bool = true
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                DayWeekView()
//                    .frame(height: 80, alignment: .center)
//                    .padding(EdgeInsets(top: 12,
//                                        leading: 15,
//                                        bottom: 8,
//                                        trailing: 15))
//                Spacer()
//                NavigationLink(destination: SelectQuestionView(isNavigationBarHidden: self.$isNavigationBarHidden)) {
//                    MotiView(color: .red)
//                        .padding(40)
//                }
//                Spacer()
//
//                HStack {
//                    Button(action: goToCalendar) {
//                        Image(systemName: "calendar")
//                            .foregroundColor(.black)
//                            .frame(width: 48, height: 48, alignment: .center)
//                            .background(Circle()
//                                .foregroundColor(.gray))
//                    }
//
//                    Spacer()
//
//                    Text("2019년 08월 28일")
//                        .font(.system(size: 20, weight: .regular, design: .default))
//
//                    Spacer()
//
//                    Button(action: goToMyPage) {
//                        Image(systemName: "person")
//                            .foregroundColor(.black)
//                            .frame(width: 48, height: 48, alignment: .center)
//                            .background(Circle()
//                                .foregroundColor(.gray))
//                    }
//
//                }
//                .padding(EdgeInsets(top: 0,
//                                    leading: 15,
//                                    bottom: 32,
//                                    trailing: 15))
//            }
//            .navigationBarTitle(Text(""))
//            .onAppear {
//                self.isNavigationBarHidden = true
//            }
//            .navigationBarHidden(isNavigationBarHidden)
//        }
//    }
//
//    func goToCalendar() {
//
//    }
//
//    func goToMyPage() {
//
//    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
