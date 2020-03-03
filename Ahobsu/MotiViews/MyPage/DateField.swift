//
//  DateField.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/01/28.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct DateField: UIViewRepresentable {
    
    typealias UIViewType = UITextField
    
    @Binding var dateString: String
    
    var textFieldDelegator: UITextFieldDelegate = ReadOnlyTextFieldDelegate()
    var datePickerHandler: DatePickerHandler = DatePickerHandler()
    
    var dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFullDate
        return formatter
    }()
    
    func makeUIView(context: UIViewRepresentableContext<DateField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.font = .monospacedDigitSystemFont(ofSize: 16, weight: .regular)
        textField.textColor = .rosegold
        textField.delegate = textFieldDelegator
        let datePicker = UIDatePickerView(frame: .zero)
        datePicker.maximumYear = Calendar.current.component(.year, from: Date())
        datePicker.date = self.dateFormatter.date(from: dateString) ?? Date()
        datePicker.addTarget(datePickerHandler,
                             action: #selector(datePickerHandler.didChangeDatePickerValue),
                             for: .valueChanged)
        datePickerHandler.didChangeDate = { newDate in
            self.dateString = self.dateFormatter.string(from: newDate)
        }
        textField.inputView = datePicker
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<DateField>) {
        UIView.animate(withDuration: 1) {
            uiView.text = self.dateString
        }
    }
}

extension DateField {
    
    class DatePickerHandler: NSObject {
        
        var didChangeDate: ((Date) -> Void)?
        
        @objc func didChangeDatePickerValue(sender: UIDatePickerView) {
            didChangeDate?(sender.date)
        }
    }
}

extension DateField {
    
    class ReadOnlyTextFieldDelegate: NSObject, UITextFieldDelegate {
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            let animator = UIViewPropertyAnimator(duration: 0.4, curve: .easeOut) {
                textField.alpha = 0.5
            }
            animator.startAnimation()
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            let animator = UIViewPropertyAnimator(duration: 0.4, curve: .easeOut) {
                textField.alpha = 1
            }
            animator.startAnimation()
        }
        
        func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
            return false
        }
    }
}
