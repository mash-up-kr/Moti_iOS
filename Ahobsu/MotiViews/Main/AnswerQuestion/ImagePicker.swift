//
//  ImagePicker.swift
//  Ahobsu
//
//  Created by 이호찬 on 2020/01/29.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @Binding var showCamera: Bool
    @Binding var image: UIImage?
    @Binding var isStatusBarHidden: Bool
    
    var sourceType: UIImagePickerController.SourceType
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var presentationMode: PresentationMode
        @Binding var showCamera: Bool
        @Binding var image: UIImage?
        @Binding var isStatusBarHidden: Bool
        
        init(presentationMode: Binding<PresentationMode>, image: Binding<UIImage?>, showCamera: Binding<Bool>, isStatusBarHidden: Binding<Bool>) {
            _presentationMode = presentationMode
            _image = image
            _showCamera = showCamera
            _isStatusBarHidden = isStatusBarHidden
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                image = uiImage
            }
            if picker.sourceType == .camera {
                showCamera = false
                isStatusBarHidden = false
            } else {
                presentationMode.dismiss()
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            if picker.sourceType == .camera {
                showCamera = false
                isStatusBarHidden = false
            } else {
                presentationMode.dismiss()
            }
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image, showCamera: $showCamera, isStatusBarHidden: $isStatusBarHidden)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
}
