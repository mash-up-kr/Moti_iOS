//
//  DiaryView.swift
//  Ahobsu
//
//  Created by bran.new on 2021/03/15.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import SwiftUI

struct Run: View {
    let block: () -> Void

    var body: some View {
        DispatchQueue.main.async(execute: block)
        return AnyView(EmptyView())
    }
}

struct DiaryView: View {

    @ObservedObject var intent: DiaryIntent
    @ObservedObject var calendarManager: MonthCalendarManager

    @Binding var isDatePickerPresented: Bool

    @State private var updatingDate: Date = Date()
    @State var initialOffset: CGPoint? = nil
    @State var offset: CGPoint = .zero

    private var referenceDate: Date = Date()

    init(diaryIntent: DiaryIntent, calendarManager: MonthCalendarManager, isDatePickerPresented: Binding<Bool>) {
        intent = diaryIntent
        self.calendarManager = calendarManager
        self._isDatePickerPresented = isDatePickerPresented
    }

    var body: some View {
        NavigationMaskingView(isRoot: true,
                              titleItem: Text("Diary"),
                              trailingItem: Button(action: { isDatePickerPresented = true },
                                                   label: { Image("icCalenderSelected").buttonSized() } )) {
            let columns: [GridItem] = [GridItem(.flexible())]
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 0) {
                            GeometryReader { geometry in
                                Run {
                                    let globalOrigin = geometry.frame(in: .global).origin
                                    self.initialOffset = self.initialOffset ?? globalOrigin
                                    let initialOffset = (self.initialOffset ?? .zero)
                                    let offset = CGPoint(x: globalOrigin.x - initialOffset.x, y: initialOffset.y - globalOrigin.y)
                                    self.offset = offset

                                    if offset.y < -10 {
                                        intent.onTopInsetAppear()
                                    }
                                }
                            }.frame(width: 0, height: 0)

                    ScrollViewReader { value in
                        LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                            ForEach(intent.answers, id: \.self) { answer in
                                if let monthTitle = intent.monthSeparatorTitle(of: answer) {
                                    DiarySeparator(title: monthTitle)
                                } else {
                                    EmptyView()
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
        }
        .background(BackgroundView())
        .onAppear(perform: {
            intent.onAppear()
        })
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView(diaryIntent: DiaryIntent(), calendarManager: MonthCalendarManager(), isDatePickerPresented: .constant(false))
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
