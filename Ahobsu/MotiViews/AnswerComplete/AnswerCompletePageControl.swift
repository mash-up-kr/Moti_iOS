//
//  PageControl.swift
//  Ahobsu
//
//  Created by 김선재 on 2019/12/18.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI
import UIKit

struct AnswerCompletePageControl: UIViewRepresentable {
    
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)
        control.currentPageIndicatorTintColor = UIColor.rosegold
        control.pageIndicatorTintColor = UIColor.greyishBrown
        control.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    class Coordinator: NSObject {
        var control: AnswerCompletePageControl
        
        init(_ control: AnswerCompletePageControl) {
            self.control = control
        }
        
        @objc
        func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}
