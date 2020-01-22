//
//  CaptureImageView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2020/01/22.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct CaptureImageView: UIViewControllerRepresentable {

    @Binding var isShown: Bool
    @Binding var image: Image?

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {

    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var imageView: CaptureImageView
        init(_ captureImageView: CaptureImageView) {
            imageView = captureImageView
        }
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            imageView.image = Image(uiImage: unwrapImage)
            imageView.isShown = false
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            imageView.isShown = false
        }
    }
}
