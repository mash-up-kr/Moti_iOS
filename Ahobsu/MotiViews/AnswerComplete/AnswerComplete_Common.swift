//
//  AnswerComplete_Common.swift
//  Ahobsu
//
//  Created by admin on 2019/11/29.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct QuestionView: View {

    @State var text: String = ""

    var questionSize: CGFloat { 28.0 }
    var questionLineSpacing: CGFloat { 16.0 }

    var body: some View {
        Text(text)
            .font(.system(size: questionSize))
            .lineSpacing(questionLineSpacing)
    }
}

struct AnswerView: View {

    @State var text: String = ""

    var answerSize: CGFloat { 16.0 }
    var answerLineSpacing: CGFloat { 8.0 }

    var body: some View {
        Text(text)
            .font(.system(size: answerSize))
            .lineSpacing(answerLineSpacing)
            .multilineTextAlignment(.center)
    }
}

struct ImageView: View {

    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()

    init(withURL url: String) {
        imageLoader = ImageLoader(urlString: url)
    }

    func imageFromData(_ data: Data) -> UIImage {
        UIImage(data: data) ?? UIImage()
    }

    var body: some View {
        Image(uiImage: imageLoader.dataIsValid ? imageFromData(imageLoader.data!) : UIImage())
        .resizable()
    }
}

class ImageLoader: ObservableObject {

    @Published var dataIsValid = false
    var data: Data?

    init(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.dataIsValid = true
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
