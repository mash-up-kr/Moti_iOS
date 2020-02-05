//
//  NavigationMaskingView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/02/05.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation
import SwiftUI

struct NavigationMaskingView<TitleItem: View, TrailingItem: View, Content: View>: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var isRoot: Bool
    var titleItem: TitleItem
    var trailingItem: TrailingItem
    var content: Content
    
    private let customHeight: CGFloat = 72
    private let originalHeight: CGFloat = 44
    private var contentPadding: CGFloat { return customHeight - originalHeight }
    
    init(isRoot: Bool = false, titleItem: TitleItem, trailingItem: TrailingItem, @ViewBuilder content: () -> Content) {
        self.isRoot = isRoot
        self.titleItem = titleItem
        self.trailingItem = trailingItem
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
                .padding(.top, contentPadding)
            GeometryReader { geometry in
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        if !self.isRoot {
                            Image("icArrowLeft").renderingMode(.original).frame(width: 44, height: 44)
                        }
                    })
                    Spacer()
                    self.titleItem
                    Spacer()
                    self.trailingItem
                }
                .frame(width: geometry.size.width, height: self.customHeight)
                .position(x: geometry.size.width / 2, y: self.customHeight / 2)
                .offset(x: 0, y: -self.originalHeight)
            }
        }.navigationBarTitle("", displayMode: .inline)
    }
}

class ff: NSObject, UINavigationControllerDelegate {
    
}
