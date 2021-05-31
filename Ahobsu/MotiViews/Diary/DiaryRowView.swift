//
//  DiaryRowView.swift
//  Ahobsu
//
//  Created by bran.new on 2021/03/15.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import SwiftUI
import Kingfisher

struct DiaryRowView: View {

    var answer: Answer

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text(answer.dateForDate?.dayText ?? "").dayStyled()
                Text(answer.dateForDate?.monthText ?? "").monthStyled()
                HStack(spacing: 4) {
                    if answer.mission.isContent { Image("icTextformNormal") }
                    if answer.mission.isImage { Image("icCameraNormal") }
                }
            }.frame(minWidth: 0, idealWidth: 68, maxWidth: 68,
                    minHeight: 0, idealHeight: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))

            ZStack(alignment:. leading) {
                if let imageURL = answer.imageUrl {
                    GeometryReader { geometry in
                        KFImage(URL(string: imageURL))
                            .placeholder({Color.yellow})
                            .resizable()
                            .opacity(0.4)
                            .scaledToFill()
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height,
                                   alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    Spacer()
                    Text(answer.mission.title).questionStyled()
                    if let content = answer.content {
                        Text(content).answerStyled()
                    }
                }.padding(EdgeInsets(top: 18, leading: 16, bottom: 18, trailing: 20))
            }
            .cornerRadius(12, corners: [.topRight, .bottomRight])
            .clipped()
        }
//        .frame(height: 128)
//        .frame(minWidth: <#T##CGFloat?#>, idealWidth: <#T##CGFloat?#>, maxWidth: <#T##CGFloat?#>, minHeight: <#T##CGFloat?#>, idealHeight: <#T##CGFloat?#>, maxHeight: <#T##CGFloat?#>, alignment: <#T##Alignment#>)
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 128, idealHeight: 128, maxHeight: 128, alignment: .leading)
        .foregroundColor(Color(.rosegold))
        .roundedBorder()
        .clipped()
    }
}

struct DiaryRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DiaryRowView(answer: Answer.dummyCardView().randomElement()!)
                .previewDisplayName("기본")
            DiaryRowView(answer: Answer.dummyCardView().randomElement()!)
                .previewDisplayName("아이콘 두개")
            DiaryRowView(answer: Answer.dummyCardView().randomElement()!)
                .previewDisplayName("긴 문자열")
        }
        .frame(width: 335, height: 128, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .previewLayout(.sizeThatFits)
    }
}

private extension Date {
    var dayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
    var monthText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: self)
    }
}

private extension Text {
    func dayStyled() -> some View {
        self.font(.custom("IropkeBatangOTFM", size: 32.0))
            .foregroundColor(Color(.rosegold))
            .lineLimit(1)
    }
    func monthStyled() -> some View {
        self.font(.custom("IropkeBatangOTFM", size: 16.0))
            .foregroundColor(Color(.rosegold))
            .lineLimit(1)
    }
    func questionStyled() -> some View {
        self.font(.custom("IropkeBatangOTFM", size: 16.0))
            .foregroundColor(Color(.rosegold))
            .lineLimit(3)
    }
    func answerStyled() -> some View {
        self.font(.custom("IropkeBatangOTFM", size: 12.0))
            .foregroundColor(Color(.rosegold))
            .lineLimit(1)
    }
}
private extension View {
    func roundedBorder() -> some View {
        self.overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.lightgold), lineWidth: 1))
    }
}
