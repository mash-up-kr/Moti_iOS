//
//  ImagePicker.swift
//  Ahobsu
//
//  Created by 이호찬 on 2020/01/29.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @Binding var showCamera: Bool
    @Binding var image: UIImage?
    @Binding var isStatusBarHidden: Bool
    
    var sourceType: UIImagePickerController.SourceType
    var isFiltered: Bool = false
    var completion: ((UIImage?) -> Void)?
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var presentationMode: PresentationMode
        @Binding var showCamera: Bool
        @Binding var image: UIImage?
        @Binding var isStatusBarHidden: Bool
        var isFiltered: Bool = false
        
        private var completion: ((UIImage?) -> Void)?
        
        private let context = CIContext()
        
        init(presentationMode: Binding<PresentationMode>, image: Binding<UIImage?>, showCamera: Binding<Bool>, isStatusBarHidden: Binding<Bool>, isFiltered: Bool = false, completion: ((UIImage?) -> Void)? = nil) {
            _presentationMode = presentationMode
            _image = image
            _showCamera = showCamera
            _isStatusBarHidden = isStatusBarHidden
            self.isFiltered = isFiltered
            self.completion = completion
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                image = isFiltered ? makeFilteredImage(image: uiImage) : uiImage
                completion?(image)
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
        
        private func makeFilteredImage(image: UIImage?) -> UIImage? {
            guard let cgImage = image?.cgImage,
                  let sepiaFilter = CIFilter(name:"CISepiaTone") else { return nil }
            
            let originalCIImage = CIImage(cgImage: cgImage)

            sepiaFilter.setValue(originalCIImage, forKey: kCIInputImageKey)
            sepiaFilter.setValue(0.9, forKey: kCIInputIntensityKey)
            
            guard let output = sepiaFilter.outputImage,
                  let newcgImage = context.createCGImage(output, from: output.extent) else { return nil }
            return UIImage(cgImage: newcgImage)
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image, showCamera: $showCamera, isStatusBarHidden: $isStatusBarHidden, isFiltered: isFiltered, completion: completion)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        #if targetEnvironment(simulator)
        picker.sourceType = .photoLibrary
        #else
        picker.sourceType = sourceType
        #endif
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
}
