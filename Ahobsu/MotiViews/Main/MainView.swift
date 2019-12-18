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
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
