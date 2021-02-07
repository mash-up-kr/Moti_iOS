//
//  PDFProcessor.swift
//  Ahobsu
//
//  Created by bran.new on 2021/02/07.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import Foundation
import SwiftUI
import Kingfisher

struct PDFProcessor: ImageProcessor {

    let identifier = "com.ahobsu.pdfprocessor"

    func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            return image
        case .data(let data):
            let pdfData = data as CFData
            guard let provider: CGDataProvider = CGDataProvider(data: pdfData) else {return nil}
            guard let pdfDoc: CGPDFDocument = CGPDFDocument(provider) else {return nil}
            guard let page: CGPDFPage = pdfDoc.page(at: 1) else {return nil}

            let pageRect = page.getBoxRect(.mediaBox)
            let renderer = UIGraphicsImageRenderer(size: pageRect.size)
            let pdfImage = renderer.image { context in
                UIColor.clear.set()
                context.fill(pageRect)
                context.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
                context.cgContext.scaleBy(x: 1.0, y: -1.0)
                context.cgContext.drawPDFPage(page)
            }
            return pdfImage
        }
    }
}
