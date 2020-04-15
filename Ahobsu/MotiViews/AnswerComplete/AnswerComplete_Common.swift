//
//  AnswerComplete_Common.swift
//  Ahobsu
//
//  Created by 김선재 on 2019/11/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct QuestionView: View {
    
    @State var text: String = ""
    
    var questionSize: CGFloat { 24.0 }
    var questionLineSpacing: CGFloat { 12.0 }
    
    var body: some View {
        Text(text)
            .font(.custom("IropkeBatangOTFM", size: questionSize))
            .lineSpacing(questionLineSpacing)
    }
}

struct AnswerView: View {
    
    @State var text: String = ""
    
    var answerSize: CGFloat { 16.0 }
    var answerLineSpacing: CGFloat { 8.0 }
    
    var body: some View {
        Text(text)
            .font(.custom("IropkeBatangOTFM", size: answerSize))
            .lineSpacing(answerLineSpacing)
            .multilineTextAlignment(.center)
    }
}

struct ImageView: View {
    
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    var url: String
    
    init(withURL url: String) {
        imageLoader = ImageLoader(urlString: url)
        self.url = url
    }
    
    func imageFromData(_ data: Data) -> UIImage {
        UIImage(data: data) ?? UIImage()
    }
    
    func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }
        
        //        let pdf = PDFDocument(data: data)
        
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.clear.set()
            ctx.fill(pageRect)
            
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            
            ctx.cgContext.drawPDFPage(page)
        }
        return img
        
        
    }
    
    func pdfToUIImage(urlString: String) -> UIImage? {
        guard let url = URL(string: urlString) else { return UIImage() }
        let image = drawPDFfromURL(url: url)
        
        let pngImage = UIImage(data: image?.pngData() ?? Data())
        
        return pngImage
    }
    
    
    var body: some View {
        if url.hasSuffix("pdf") {
            return Image(uiImage: pdfToUIImage(urlString: url) ?? UIImage())
                .renderingMode(.original)
                .resizable()
        } else {
            return Image(uiImage: UIImage(data: imageLoader.data ?? Data()) ?? UIImage())
                .renderingMode(.original)
                .resizable()
        }
    }
}

class ImageLoader: ObservableObject {
    
    @Published var data: Data?
    
    init(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct AnswerComplete_Common: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
