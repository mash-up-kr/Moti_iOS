//
//  MainView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var isNavigationBarHidden: Bool = true

    var body: some View {
        NavigationView {
            ZStack {
                Image("bgColor")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea([.top])
                VStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(16)
                            .shadow(radius: 10)
                            .foregroundColor(.white)
                            .frame(height: 120, alignment: .center)
                            .offset(x: 0, y: -15)

                        DayWeekView()
                            .frame(height: 80, alignment: .center)
                            .padding(EdgeInsets(top: 12,
                                                leading: 15,
                                                bottom: 8,
                                                trailing: 15))
                    }
                    Spacer()
                    NavigationLink(destination: SelectQuestionView(isNavigationBarHidden: self.$isNavigationBarHidden)) {
                        MotiView(color: Color(red: 143/255, green: 164/255, blue: 255/255))
                            .padding(40)

                    }
                    Spacer(minLength: 100)

                    HStack {
                        Button(action: goToCalendar) {
                            Image(systemName: "calendar")
                                .foregroundColor(.black)
                                .frame(width: 48, height: 48, alignment: .center)
                                .background(Circle()
                                    .foregroundColor(.white))
                            .shadow(radius: 10)
                        }

                        Spacer()

                        Text("2019. 08. 28.")
                            .font(.system(size: 20, weight: .regular, design: .default))
                            .background(Capsule()
                                .padding(.horizontal, -39)
                                .padding(.vertical, -12)
                                .foregroundColor(.white))
                            .shadow(radius: 10)

                        Spacer()

                        Button(action: goToMyPage) {
                            Image(systemName: "person")
                                .foregroundColor(.black)
                                .frame(width: 48, height: 48, alignment: .center)
                                .background(Circle()
                                    .foregroundColor(.white))
                            .shadow(radius: 10)
                        }

                    }
                    .padding(EdgeInsets(top: 0,
                                        leading: 15,
                                        bottom: 32,
                                        trailing: 15))
                }
                .navigationBarTitle(Text(""))
                .onAppear {
                    self.isNavigationBarHidden = true
                }
                .navigationBarHidden(isNavigationBarHidden)
            }
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
