//
//  UIDateField.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/03/04.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import UIKit
import SwiftUI

final class UIDateField: UITextField {
    
    @Binding var date: Date
    
    init(selection: Binding<Date>) {
        _date = selection
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var inputViewController: UIInputViewController? {
        let hostingVC = UIHostingController(rootView: DatePickerView(selection: $date))
        let inputVC = UIInputViewController(nibName: nil, bundle: nil)
        inputVC.addChild(hostingVC)
        inputVC.view.addSubview(hostingVC.view)
        
        hostingVC.didMove(toParent: inputVC)
        return inputVC
    }
}
