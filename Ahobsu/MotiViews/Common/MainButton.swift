//
//  MainButton.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2019/12/19.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

private struct MainButtonFeel: ViewModifier {
    
    var isEnabled: Bool
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(isEnabled ? Color(.pinkishTan) : Color(.disableText))
            .font(.system(size: 16))
            .frame(minWidth: 204, minHeight: 40, alignment: .center)
            .background(isEnabled ? Color.white : Color(.disableblack))
            .cornerRadius(20)
            .shadow(color: isEnabled ? Color(.shadowpink) : .clear, radius: 10 / 2, x: 0, y: 0 )
            .animation(.easeOut)
    }
}

struct MainButton: View {
    
    @Environment(\.isEnabled) var isEnabled
    var action: (() -> Void)?
    var title: String
    
    var body: some View {
        ZStack {
            if action != nil {
                Button(action: action!) {
                    Text(title)
                        .modifier(MainButtonFeel(isEnabled: isEnabled))
                }
            } else {
                Text(title)
                    .modifier(MainButtonFeel(isEnabled: isEnabled))
            }
        }.disabled(!isEnabled)
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 버튼 자체로 사용될 때, able
            MainButton(action: {
                
            }, title: "Default Able Button").environment(\.isEnabled, true)
            // 버튼 자체로 사용될 때, disabled
            MainButton(action: {
                
            }, title: "Default Disabled Button").environment(\.isEnabled, false)
            // NavigationLink로 활용될 때, able
            MainButton(title: "Text Able Button").environment(\.isEnabled, true)
            // NavigationLink로 활용될 때, disabled
            MainButton(title: "Text Disabled Button").environment(\.isEnabled, false)
        }.previewLayout(.fixed(width: 204 + 30, height: 40 + 30))
    }
}
