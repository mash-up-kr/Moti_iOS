//
//  TextView.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/03/17.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import UIKit
import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let myTextView = UITextView()
        myTextView.delegate = context.coordinator
        myTextView.backgroundColor = .red
        
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.backgroundColor = .clear
        myTextView.tintColor = .rosegold
        
        let textViewAttributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "IropkeBatangOTFM", size: 16.0)!,
            .foregroundColor: UIColor.rosegold,
            .paragraphStyle: {
                let paragraph = NSMutableParagraphStyle()
                paragraph.lineSpacing = 8.0
                paragraph.alignment = .left
                return paragraph
            }()
        ]
        
        myTextView.typingAttributes = textViewAttributes
        
        return myTextView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    final class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: TextView
        
        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }
        
        func textViewDidChange(_ textView: UITextView) {
            // print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
        }
    }
}
