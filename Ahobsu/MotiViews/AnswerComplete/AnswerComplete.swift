//
//  AnswerComplete.swift
//  Ahobsu
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Combine
import SwiftUI

enum AnswerMode {
    case essay
    case camera
    case essayCamera
}

struct AnswerCompleteView: View {
    
    var answerMode: AnswerMode

    var contentView: some View {
        switch answerMode {
        case .essay:
            return AnyView(AnswerComplete_Essay())
        case .camera:
            return AnyView(AnswerComplete_Camera())
        case .essayCamera:
            return AnyView(AnswerComplete_EssayCamera())
        }
    }

    var body: some View {
        ZStack {
            contentView
            AnyView(Navigation())
        }
    }
}

struct Navigation: View {
    
    var buttonWidth: CGFloat { 44.0 }
    var buttonHeight: CGFloat { 44.0 }

    var backButton: some View {
        Button(action: {
            print("Tapped")
        }, label: {
            Text("<")
        }).frame(width: buttonWidth, height: buttonHeight, alignment: .center)
    }

    var body: some View {
        VStack {
            HStack {
                backButton
                Spacer()
            }
            Spacer()
        }
    }
}

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
    
    var imageMaxHeight: CGFloat { 375.0 }

    init(withURL url: String) {
        imageLoader = ImageLoader(urlString: url)
    }

    func imageFromData(_ data: Data) -> UIImage {
        UIImage(data: data) ?? UIImage()
    }

    var body: some View {
        VStack {
            Image(uiImage: imageLoader.dataIsValid ? imageFromData(imageLoader.data!) : UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: imageMaxHeight)
        }
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

struct AnswerComplete_Essay: View {
    
    var questionViewText: String {
        "오늘 비가와요.\n비를 주제로\n한줄 시를 써볼까요?"
    }
    
    var circleWidth: CGFloat { 268.0 }
    var circleHeight: CGFloat { 268.0 }
    
    var questionPaddingTop: CGFloat { 80.0 }
    var questionPaddingLeading: CGFloat { 15.0 }
    var questionPaddingTrailing: CGFloat { 15.0 }
    
    var answerViewText: String { "종로3가 순두부 식당 맛있어보인다.\n갈지 말지 고민됨\n밖은 너무 추워보임..." }
    
    var answerPaddingTop: CGFloat { 20.0 }
    var answerMaxHeight: CGFloat { 272.0 }
    var answerBackgroundColor: Color {
        Color.init(red: 216/255, green: 216/255, blue: 216/255)
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                HStack {
                    QuestionView(text: questionViewText)
                    Spacer()
                }
                Circle()
                    .fill(Color.gray)
                    .frame(width: circleWidth,
                           height: circleHeight)
                Spacer()
            }.padding(.top, questionPaddingTop)
                .padding(.leading, questionPaddingLeading)
                .padding(.trailing, questionPaddingTrailing)

            VStack {
                Spacer()
                VStack {
                    AnswerView(text: answerViewText)
                    Spacer()
                }.padding(.top, answerPaddingTop)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: answerMaxHeight)
                    .background(answerBackgroundColor)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
    }
}

struct AnswerComplete_Camera: View {

    var cameraViewSpacing: CGFloat { 60.0 }
    
    var questionViewText: String {
        "오늘의 먹은 음식을\n사진으로 남겨보세요.\n세줄짜리"
    }
    
    var questionPaddingTop: CGFloat { 80.0 }
    var questionPaddingLeading: CGFloat { 15.0 }
    var questionPaddingTrailing: CGFloat { 15.0 }
    
    var sampleImageURL: String {
        "https://cdn.pixabay.com/photo/2018/09/02/14/42/river-3648947_1280.jpg"
    }
    
    var body: some View {
        VStack(spacing: cameraViewSpacing) {
            VStack {
                HStack {
                    QuestionView(text: questionViewText)
                    Spacer()
                }
            }.padding(.top, questionPaddingTop)
                .padding(.leading, questionPaddingLeading)
                .padding(.trailing, questionPaddingTrailing)
            ImageView(withURL: sampleImageURL)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
    }
}

struct AnswerComplete_EssayCamera: View {
    
    var cameraViewSpacing: CGFloat { 0.0 }
    
    var sampleImageURL: String {
        "https://cdn.pixabay.com/photo/2018/09/02/14/42/river-3648947_1280.jpg"
    }
    
    var questionViewText: String {
        "오늘의 먹은 음식을\n사진으로 남겨보세요.\n세줄짜리"
    }
    
    var questionViewColor: COlor { Color.white }
    
    var questionPaddingLeading: CGFloat { 15.0 }
    var questionPaddingBottom: CGFloat { 15.0 }
    
    var questionMaxHeight: CGFloat { 375.0 }
    
    var answerViewText: String { "오늘 비가 와요.\n비를 주제로 사진과 함께\n한 줄 시를 써볼까요?" }
    
    var answerPaddingTop: CGFloat { 20.0 }
    var answerBackgroundColor: Color {
        Color.init(red: 216/255, green: 216/255, blue: 216/255)
    }
    
    var body: some View {
        VStack(spacing: cameraViewSpacing) {
            ZStack {
                ImageView(withURL: sampleImageURL)
                    .overlay(
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, .black]),
                                    startPoint: .center,
                                    endPoint: .bottom)
                        )
                            .clipped()
                )
                VStack {
                    Spacer()
                    HStack {
                        QuestionView(text: questionViewText)
                            .foregroundColor(questionViewColor)
                        Spacer()
                    }.padding(.leading, questionPaddingLeading)
                        .padding(.bottom, questionPaddingBottom)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: questionMaxHeight)
            VStack {
                AnswerView(text: answerViewText)
                    .multilineTextAlignment(.center)
                Spacer()
            }.padding(.top, answerPaddingTop)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(answerBackgroundColor)
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
    }
}

struct AnswerCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AnswerCompleteView(answerMode: .essay)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max - Essay")

            AnswerCompleteView(answerMode: .camera)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max - Camera")

            AnswerCompleteView(answerMode: .essayCamera)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max - EssayCamera")
        }
    }
}
