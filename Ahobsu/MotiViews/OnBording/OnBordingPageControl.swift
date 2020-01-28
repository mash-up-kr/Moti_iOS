//
//  PageControl.swift
//  Ahobsu
//
//  Created by admin on 2020/01/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI
import UIKit

struct OnBordingPageControl: UIViewRepresentable {

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
        var control: OnBordingPageControl

        init(_ control: OnBordingPageControl) {
            self.control = control
        }

        @objc
        func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}
