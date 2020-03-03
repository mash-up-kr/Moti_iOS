//
//  GenderField.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/01/28.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct GenderInputView: View {
    
    @Binding var genderRawValue: String
    
    var body: some View {
        HStack {
            ForEach(SignUp.Gender.allCases, id: \.self) { (gender) in
                Button(action: {
                    self.genderRawValue = gender.rawValue
                }, label: {
                    GenderCardView(gender: SignUp.Gender(rawValue: gender.rawValue) ?? .male)
                }).padding(.horizontal, 15.0)
                    .opacity((self.genderRawValue == gender.rawValue) ? 1 : 0.5)
                    .animation(.easeOut)
            }
        }
    }
}

struct GenderField: UIViewRepresentable {
    
    typealias UIViewType = UITextField
    
    @Binding var gender: String
    
    var textFieldDelegator: UITextFieldDelegate = ReadOnlyTextFieldDelegate()
    
    func makeUIView(context: UIViewRepresentableContext<GenderField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.font = .monospacedDigitSystemFont(ofSize: 16, weight: .regular)
        textField.textColor = .rosegold
        textField.delegate = textFieldDelegator
        
        let genderInputView = GenderInputView(genderRawValue: $gender)
        let hostingViewController = UIHostingController(rootView: genderInputView)
        hostingViewController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 256)
        hostingViewController.view.tintColor = .rosegold
        textField.inputView = hostingViewController.view
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<GenderField>) {
        uiView.text = self.gender
    }
}

extension GenderField {
    
    class ReadOnlyTextFieldDelegate: NSObject, UITextFieldDelegate {
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            // Nothing
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            // Nothing
        }
        func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
            return false
        }
    }
}
