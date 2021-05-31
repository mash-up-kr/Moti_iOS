//
//  DiaryView.swift
//  Ahobsu
//
//  Created by bran.new on 2021/03/15.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import SwiftUI

struct DiaryView: View {

    @ObservedObject var intent: DiaryIntent

    @State private var isDatePickerPresented: Bool = false
    @State private var updatingDate: Date = Date()

    private var referenceDate: Date = Date()
    var calendarManager = MonthCalendarManager()

    init(diaryIntent: DiaryIntent) {
        intent = diaryIntent
    }

    var body: some View {
        NavigationMaskingView(isRoot: true,
                              titleItem: Text(intent.date.titleText),
                              trailingItem: Button(action: { isDatePickerPresented = true },
                                                   label: { Image("icCalenderSelected").buttonSized() } )) {
            let columns: [GridItem] = [GridItem(.flexible())]
            ScrollView(.vertical) {
                ScrollViewReader { value in
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                        ForEach(intent.answers, id: \.self) { answer in
                            if intent.shouldHaveMonthSeparator(with: answer) {
                                DiarySeparator()
                            }
                            DiaryRowView(answer: answer)
                                .onAppear { intent.onRowAppear(answer: answer) }
                                .id(answer.id)
                        }
                    }.padding(20)
                    .onReceive(intent.$specificPosition) { targetPosition in
                        withAnimation {
                            value.scrollTo(targetPosition, anchor: .top)
                        }
                    }
                }
            }
        }
        .background(BackgroundView())
        .onAppear(perform: {
            intent.onAppear()
        })
        .bottomSheet(isPresented: $isDatePickerPresented,
                     height: 400,
                     showTopIndicator: false) {
            VStack {
                CalendarDatePicker(calendarManager: calendarManager, selection: $intent.date) {
                    isDatePickerPresented = false
                }
            }
        }
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView(diaryIntent: DiaryIntent())
    }
}

private extension Image {
    func buttonSized() -> some View {
        self.renderingMode(.original).frame(width: 48, height: 48)
    }
}

private extension Date {
    var titleText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        return formatter.string(from: self)
    }
}
