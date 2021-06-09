//
//  AlbumView.swift
//  Ahobsu
//
//  Created by 김선재 on 28/01/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI
import Kingfisher

struct AlbumView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var intent: AlbumItent


    var itemRows: [GridItem] = Array(repeating: GridItem(.fixed(316), spacing: 0), count: 1)
    var itemHeight: CGFloat = 316
    var itemSpacing: CGFloat = 28

    var body: some View {
//        NavigationView {
            NavigationMaskingView(isRoot: true, titleItem: EmptyView(), trailingItem: EmptyView()) {
                VStack {
                    if intent.isReloadNeeded {
                        NetworkErrorView {
                            intent.onError()
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    } else {
                        if intent.answerMonth.isEmpty {
                            AnswerEmptyView()
                        } else {
                            VStack {
                                shelf
                                albums
                                Spacer()
                            }
                        }
                    }
                }
                .disabled(intent.isLoading)
                .blur(radius: intent.isLoading ? 3 : 0)
            }
            .background(BackgroundView())
            .overlay(LoadingView(isShowing: intent.isLoading))
//        }
    }

    var shelf: some View {
        // PATCH: GeometryReader로 감쌌을 때 Image의 Default offset이 0에 위치하게됨.
        GeometryReader { _ in
            HStack {
                Image(intent.shelfName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: intent.shelfHeight)
                    .offset(x: intent.shelfXOffset)
            }
        }.frame(height: intent.shelfHeight)
    }

    var albums: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: itemRows, spacing: itemSpacing) {
                    Color.clear.frame(width: geometry.size.width / 4 - itemSpacing)
                    ForEach(intent.answerMonth, id: \.self) { answers in
                        PartsCombinedAnswer(answers: answers, fixedWidth: geometry.size.width / 2)
                            .onAppear { intent.onRowAppear(answers: answers) }
                    }
                    Color.clear.frame(width: geometry.size.width / 4 - itemSpacing)
                }
            }.frame(height: itemHeight)
        }
    }
}

struct AnswerEmptyView: View {
    
    var imageName: String { "icEmpty" }
    var imagePaddingBottom: CGFloat { 16.0 }
    
    var sublineText: String { "이달에는 수집된 카드가 없습니다." }
    var sublineTextFont: Font { Font.custom("IropkeBatangOTFM", size: 14.0) }
    var sublineLineSpacing: CGFloat { 6.0 }
    
    var body: some View {
        VStack {
            Spacer()
            Image("icEmpty")
                .padding(.bottom, imagePaddingBottom)
            Text(sublineText)
                .font(sublineTextFont)
                .lineSpacing(sublineLineSpacing)
                .foregroundColor(Color(UIColor.rosegold))
            Spacer()
        }
    }
}

struct PartsCombinedAnswer: View {

    var answers: [Answer?]

    // PATCH: LazyHGrid에서 다시 그릴 때 placeholder가 생기면서 사이즈가 변경되는 것 방지
    var fixedWidth: CGFloat
    
    init(answers: [Answer?], fixedWidth: CGFloat) {
        self.answers = answers
        self.fixedWidth = fixedWidth
        
        // nil 로 상단 뷰에서 확인
        while self.answers.count < 6 {
            self.answers.append(nil)
        }
    }
    
    var body: some View {
        // FIXME: 답변화면 2.0 적용하기
        NavigationLink(destination: AnswerCompleteView(answers)) {
            ZStack {
                ForEach(self.answers.compactMap { $0?.file.cardUrl },
                        id: \.self,
                        content: { (cardUrl) in
                            // FIXME: LazyHGrid에서 스크롤할 때 인디케이터가 뜨지 않도록
                            KFImage.url(URL(string: cardUrl) ?? URL(string: ""))
                                .placeholder( { ActivityIndicator(isAnimating: .constant(true), style: .medium) } )
                                .setProcessor(PDFProcessor())
                                .fade(duration: 0.25)
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(0.62, contentMode: .fit)
                })
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(width: fixedWidth)
    }
}
