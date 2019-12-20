//
//  SelectQuestionView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct SelectQuestionView: View {
    @Binding var currentPage: Int

    @State var index: Int = 0

    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea([.vertical])
            VStack {
//                HStack {
//                    VStack {
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack(alignment: .top, spacing: 24) {
//                                QuestionCardView()
//                                QuestionCardView()
//                                //                                .opacity(0.5)
//                                QuestionCardView()
//                            }
//                            .padding([.vertical], 10)
//                            .padding([.horizontal], 60)
//                        }
//                        .frame(height: 450, alignment: .center)
//                    }
//                }

                VStack {
                    SwiftUIPagerView(index: $index, pages: (0..<3).map { index in QuestionCardView(id: index) })
                    .frame(height: 420, alignment: .center)

//                    SwiftUIPagerView(index: $index, pages: [QuestionCardView(), QuestionCardView(), QuestionCardView()])

                    PageControl(numberOfPages: 3, currentPage: $index)
//                    Picker(selection: self.$index.animation(.easeInOut), label: Text("")) {
//                        ForEach(0..<3) { page in Text("\(page + 1)").tag(page) }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                    .padding()
                }

            }
        }
    }
}

struct SelectQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SelectQuestionView(currentPage: .constant(0))
    }
}
