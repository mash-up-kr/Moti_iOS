//
//  MainCardView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/12/18.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

enum CardViewType {
    case Main
    case Option
}

struct CardView: View {
    @State private var innerLine: Bool = false
    
    @State private var outterCornerRadius: CGFloat = 11.0
    @State private var innerCornerRadius: CGFloat = 11.0
    
    @State private var outterShadowRadius: CGFloat = 10.0
    @State private var outterShadowColor: Color = Color(.shadowpink)
    
    @State private var innerPaddingTop: CGFloat = 10.0
    @State private var innerPaddingLeading: CGFloat = 10.0
    
    @State private var innerMarginTop: CGFloat = 7.0
    @State private var innerMarginLeading: CGFloat = 2.0
    
    @State private var outterBorderWidth: CGFloat = 1.0
    @State private var innerBorderWidth: CGFloat = 1.0
    
    @State private var outterBorderColor: Color = Color(.lightgold)
    @State private var innerBorderColor: Color = Color(.lightgold)
    
    init(innerLine: Bool) {
        self.innerLine(innerLine)
    }
    
    func render(cardViewType: CardViewType) -> Self {
        var copy = self
        
        switch cardViewType {
        case .Main:
            copy.cornerRadius()
            copy.outterShadow()
            copy.innerPadding()
            copy.innerMargin()
            copy.borderWidth()
            copy.borderColor()
        case .Option:
            copy.cornerRadius(outterCornerRadius: 6.6, innerCornerRadius: 6.6)
            copy.outterShadow()
            copy.innerPadding(innerPaddingTop: 6.0, innerPaddingLeading: 6.0)
            copy.innerMargin()
            copy.borderWidth(outterBorderWidth: 0.6, innerBorderWidth: 0.6)
            copy.borderColor()
        }
        
        return copy
    }
    
    mutating func innerLine(_ hasInnerLine: Bool = false) {
        self._innerLine = .init(initialValue: hasInnerLine)
    }
    
    mutating func cornerRadius(outterCornerRadius: CGFloat = 11.0, innerCornerRadius: CGFloat = 11.0) {
        self._outterCornerRadius = .init(initialValue: outterCornerRadius)
        self._innerCornerRadius = .init(initialValue: innerCornerRadius)
    }
    
    mutating func outterShadow(outterShadowRadius: CGFloat = 10.0, outterShadowColor: Color = Color(.shadowpink)) {
        self._outterShadowRadius = .init(initialValue: outterShadowRadius)
        self._outterShadowColor = .init(initialValue: outterShadowColor)
    }
    
    mutating func innerPadding(innerPaddingTop: CGFloat = 10.0, innerPaddingLeading: CGFloat = 10.0) {
        self._innerPaddingTop = .init(initialValue: innerPaddingTop)
        self._innerPaddingLeading = .init(initialValue: innerPaddingLeading)
    }
    
    mutating func innerMargin(innerMarginTop: CGFloat = 7.0, innerMarginLeading: CGFloat = 2.0) {
        self._innerMarginTop = .init(initialValue: innerMarginTop)
        self._innerMarginLeading = .init(initialValue: innerMarginLeading)
    }
    
    mutating func borderWidth(outterBorderWidth: CGFloat = 1.0, innerBorderWidth: CGFloat = 1.0) {
        self._outterBorderWidth = .init(initialValue: outterBorderWidth)
        self._innerBorderWidth = .init(initialValue: innerBorderWidth)
    }
    
    mutating func borderColor(outterBorderColor: Color = Color(.lightgold), innerBorderColor: Color = Color(.lightgold)) {
        self._outterBorderColor = .init(initialValue: outterBorderColor)
        self._innerBorderColor = .init(initialValue: innerBorderColor)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: outterCornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: outterCornerRadius)
                        .stroke(outterBorderColor, lineWidth: outterBorderWidth)
                )
                .foregroundColor(.black)
                .shadow(color: outterShadowColor, radius: outterShadowRadius / 2, x: 0, y: 0)
                .overlay(
                    ZStack {
                        if innerLine {
                            RoundedRectangle(cornerRadius: innerCornerRadius)
                                .overlay(
                                    RoundedRectangle(cornerRadius: innerCornerRadius)
                                        .stroke(innerBorderColor, lineWidth: innerBorderWidth)
                                )
                                .foregroundColor(.clear)
                                .padding([.vertical], innerPaddingTop + innerMarginTop)
                                .padding([.horizontal], innerPaddingLeading + innerMarginLeading)
                                
                            RoundedRectangle(cornerRadius: innerCornerRadius)
                                .overlay(
                                    RoundedRectangle(cornerRadius: innerCornerRadius)
                                        .stroke(innerBorderColor, lineWidth: innerBorderWidth)
                                )
                                .foregroundColor(.clear)
                                .padding([.vertical], innerPaddingLeading + innerMarginLeading)
                                .padding([.horizontal], innerPaddingTop + innerMarginTop)
                        }
                    }
            )
                .foregroundColor(.clear)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(innerLine: true)
    }
}
