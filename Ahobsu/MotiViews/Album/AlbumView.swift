//
//  AlbumView.swift
//  Ahobsu
//
//  Created by admin on 28/01/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

extension String {
    static func toAlbumDateString(from date: Date) -> String {
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        
        let monthEnum = MonthEnum(month: month)
        let returnStr = "\(year). \(monthEnum.longMonthString())"
        
        return returnStr
    }
    
    static func toAlbumDateString(year: Int, month: Int) -> String {
        let monthEnum = MonthEnum(month: month)
        let returnStr = "\(year). \(monthEnum.longMonthString())"
        
        return returnStr
    }
}

struct AlbumView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var answerMonth: AnswerMonth?
    
    @State private var currentYear: Int = 0
    @State private var currentMonth: Int = 0
    
    func loadAlbums() {
        AhobsuProvider.getAnswersMonth(year: self.currentYear,
                                       month: self.currentMonth,
                                       completion: { (wrapper) in
                                        if let answerMonth = wrapper?.data {
                                            self.answerMonth = answerMonth
                                        }
        }, error: { (error) in
            print(error)
        }, expireTokenAction: {
            
        }, filteredStatusCode: nil)
    }
    
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            HStack {
                Image("icArrowLeft")
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        })
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                    .edgesIgnoringSafeArea([.vertical])
                ScrollView {
                    VStack {
                        AlbumList(answerMonth: answerMonth)
                        Spacer()
                    }
                    .padding([.leading, .trailing], 15.0)
                    .padding(.top, 30.0)
                }
                PaginationView(loadAlbumsDelegate: { self.loadAlbums() }, year: $currentYear, month: $currentMonth)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
            .onAppear {
                let calendar = Calendar.current
                let date = Date()
                
                self.currentYear = calendar.component(.year, from: date)
                self.currentMonth = calendar.component(.month, from: date)
                
                self.loadAlbums()
            }
            .navigationBarItems(leading: btnBack)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(Text("앨범")
            .font(.custom("AppleSDGothicNeo-Regular", size: 16.0)), displayMode: .inline)
            .background(NavigationConfigurator { navConfig in
                navConfig.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
                navConfig.navigationBar.titleTextAttributes = [
                    .foregroundColor: UIColor.rosegold
                ]
            })
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct AlbumList: View {
    
    var answerMonth: AnswerMonth?
    
    var body: some View {
        VStack {
            if answerMonth != nil {
                GridStack(rows: Int(Double(self.answerMonth!.answers.count) / 2.0 + 0.5), columns: 2) { (row, column) in
                    if row * 2 + column + 1 <= self.answerMonth!.answers.count {
                        PartsCombinedAnswer(answers: self.answerMonth!.answers[row * 2 + column], week: row * 2 + column + 1)
                    } else {
                        Text("")
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                }
            }
        }
    }
}

struct PartsCombinedAnswer: View {
    
    var answers: [Answer?]?
    var week: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            HStack(alignment: .center) {
                Rectangle().fill(Color(.rosegold))
                    .frame(height: 1.0)
                if week == 1 {
                    Text("1st week").font(.custom("IropkeBatangM", size: 16.0)).lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                } else if week == 2 {
                    Text("2nd week").font(.custom("IropkeBatangM", size: 16.0)).lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                } else if week == 3 {
                    Text("3rd week").font(.custom("IropkeBatangM", size: 16.0)).lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                } else {
                    Text("\(week)th week").lineLimit(1)
                        .fixedSize(horizontal: true, vertical: false)
                }
                Rectangle().fill(Color(.rosegold))
                    .frame(height: 1.0)
            }
            ZStack {
                if answers != nil {
                    ForEach(self.answers!.compactMap { $0?.cardUrl },
                            id: \.self,
                            content: { (cardUrl) in
                                ImageView(withURL: cardUrl)
                                    .aspectRatio(0.62, contentMode: .fit)
                                    .padding(20)
                    })
                }
            }.frame(height: 273.0)
        }
    }
    
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows) { row in
                HStack(spacing: 25.0) {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

struct PaginationView: View {
    
    var loadAlbumsDelegate: () -> Void
    
    @Binding var year: Int
    @Binding var month: Int
    
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center, spacing: 8.0) {
                Button(action: {
                    /* 뒤로 가기 */
                    if self.month == 1 {
                        self.month = 12
                        self.year -= 1
                    } else {
                        self.month -= 1
                    }
                    
                    self.loadAlbumsDelegate()
                }, label: {
                    Image("icArrowLeft")
                        .renderingMode(.original)
                })
                    .frame(width: 48.0, height: 48.0)
                Text(String.toAlbumDateString(year: year, month: month))
                    .lineSpacing(16.0).lineLimit(1)
                    .font(.custom("IropkeBatangM", size: 20.0))
                    .frame(width: 160.0)
                Button(action: {
                    /* 앞으로 가기 */
                    if self.month == 12 {
                        self.month = 1
                        self.year += 1
                    } else {
                        self.month += 1
                    }
                    
                    self.loadAlbumsDelegate()
                }, label: {
                    Image("icArrowRight")
                        .renderingMode(.original)
                })
                    .frame(width: 48.0, height: 48.0)
            }
            .frame(height: 88.0)
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView()
    }
}
