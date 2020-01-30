//
//  UINavigationController+Extension.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/01/29.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import UIKit

extension UINavigationController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        let backButtonImage = UIImage(named: "icArrowLeft")?.withRenderingMode(.alwaysOriginal)
        navigationBar.backIndicatorImage = backButtonImage
        navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(color: .black), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}

public extension UIImage {

    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
