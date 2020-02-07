//
//  AlbumView.swift
//  Ahobsu
//
//  Created by admin on 28/01/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct AlbumView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var answerMonth: AnswerMonth?
    
    @State private var currentYear = 0
    @State private var currentMonth = 0
    
    let formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    init() {
        formatter.formatOptions = .withYear
        self.currentYear = Int(formatter.string(from: Date()))!
        
        formatter.formatOptions = .withMonth
        self.currentMonth = Int(formatter.string(from: Date()))!
        
        print("currentYear : \(currentYear) and currentMonth : \(currentMonth)")
    }
    
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
                AlbumList(answerMonth: $answerMonth)
                    .onAppear {
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
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct AlbumList {
    
    @Binding var answerMonth: AnswerMonth?
    
    var body: some View {
        VStack {
            if answerMonth != nil {
                GridStack(rows: self.answerMonth.answers.count / 2, columns: 2) { (row, column) -> _ in
                    if self.answerMonth.answers[row * 2 + column] != nil {
                        ForEach(self.answerMonth.answers[row * 2 + column].compactMap { $0?.cardUrl },
                                id: \.self,
                                content: { (cardUrl) in
                                    ImageView(withURL: cardUrl)
                                        .aspectRatio(0.62, contentMode: .fit)
                                        .padding(20)
                        })
                    }
                }
            }
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows) { row in
                HStack {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView()
    }
}
