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
    
    init(isRoot: Bool = false, titleItem: TitleItem, trailingItem: TrailingItem, @ViewBuilder content: () -> Content) {
        self.isRoot = isRoot
        self.titleItem = titleItem
        self.trailingItem = trailingItem
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                MainNavigationBar(left: {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        if !self.isRoot {
                            Image("icArrowLeft").renderingMode(.original).frame(width: 48, height: 48)
                        }
                    })
                }, center: {
                    self.titleItem.foregroundColor(Color(.rosegold))
                }, right: {
                    self.trailingItem
                })
            }.frame(height: self.customHeight)
            VStack {
                content
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
