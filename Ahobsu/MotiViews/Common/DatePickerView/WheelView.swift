//
//  WheelView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/02/19.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct WheelView: UIViewRepresentable {
    
    @Binding var selectedItem: Int
    var items: [Int]
    
    func makeUIView(context: UIViewRepresentableContext<WheelView>) -> UIWheelView {
        let wheelView = UIWheelView(items: items)
        wheelView.delegate = context.coordinator
        return wheelView
    }
    
    func updateUIView(_ uiView: UIWheelView, context: UIViewRepresentableContext<WheelView>) {
        uiView.selectedItem = selectedItem
    }
}

extension WheelView {
    
    class Coordinator: NSObject, UIWheelViewDelegate {
        
        @Binding var selectedItem: Int
        
        init(selectedItem: Binding<Int>) {
            _selectedItem = selectedItem
            super.init()
        }
        
        func wheelView(_ wheelView: UIWheelView, didSelectItem item: Int) {
            selectedItem = item
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedItem: $selectedItem)
    }
}
