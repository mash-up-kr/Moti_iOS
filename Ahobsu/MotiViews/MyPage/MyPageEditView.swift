//
//  MyPageEditView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/01/27.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct MyPageEditView: View {

    @Binding var user: User

    var body: some View {
        ScrollView {
            VStack {
                MyPageView.Separator()
                ListCell(title: "닉네임", detail: user.name)
                MyPageView.Separator()
                ListCell(title: "생년월일", detail: user.birthday)
                MyPageView.Separator()
                ListCell(title: "성별", detail: user.gender)
                MyPageView.Separator()
            }
        }
    }
}

struct MyPageEditView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageEditView(user: .constant(.sampleData))
    }
}

extension MyPageEditView {
    struct ListCell: View {
        var title: String
        var detail: String
        var body: some View {
            HStack {
                Text(title)
                Spacer()
                Text(detail)
                Spacer()
            }.frame(minHeight: 52)
            .foregroundColor(Color(.rosegold))
        }
    }
}
