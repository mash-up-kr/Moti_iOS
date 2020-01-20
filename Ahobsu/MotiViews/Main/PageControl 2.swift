//
//  PageControl.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/12/20.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI
import UIKit

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.currentPageIndicatorTintColor = .lightgold
        control.pageIndicatorTintColor = .greyishBrown

//        let scale: CGFloat = 1
//        control.transform = CGAffineTransform.init(scaleX: scale, y: scale)
//
//        for dot in control.subviews {
//            dot.transform = CGAffineTransform.init(scaleX: 1/4, y: 1/4)
//        }

        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)

        return control
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }

    class Coordinator: NSObject {
        var control: PageControl

        init(_ control: PageControl) {
            self.control = control
        }

        @objc func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}
