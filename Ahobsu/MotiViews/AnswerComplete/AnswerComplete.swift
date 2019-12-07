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

struct AnswerComplete: View {
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

    var backButton: some View {
        Button(action: {
            print("Tapped")
        }, label: {
            Text("<")
        }).frame(width: 44.0, height: 44.0, alignment: .center)
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

    var body: some View {
        Text(text)
            .font(.system(size: 28.0))
            .lineSpacing(16.0)
    }
}

struct AnswerView: View {
    @State var text: String = ""

    var body: some View {
        Text(text)
            .font(.system(size: 16.0))
            .lineSpacing(8.0)
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
        VStack {
            Image(uiImage: imageLoader.dataIsValid ? imageFromData(imageLoader.data!) : UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 375.0)
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
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                HStack {
                    QuestionView(text: "오늘 비가와요.\n비를 주제로\n한줄 시를 써볼까요?")
                    Spacer()
                }
                Circle()
                    .fill(Color.gray)
                    .frame(width: 268, height: 268)
                Spacer()
            }.padding(.top, 80.0)
                .padding(.leading, 15.0)
                .padding(.trailing, 15.0)

            VStack {
                Spacer()
                VStack {
                    AnswerView(text: "종로3가 순두부 식당 맛있어보인다.\n갈지 말지 고민됨\n밖은 너무 추워보임...")
                    Spacer()
                }.padding(.top, 20)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 272.0)
                    .background(Color.init(red: 216/255, green: 216/255, blue: 216/255))
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
    }
}

struct AnswerComplete_Camera: View {

    var body: some View {
        VStack(spacing: 60.0) {
            VStack {
                HStack {
                    QuestionView(text: "오늘의 먹은 음식을\n사진으로 남겨보세요.\n세줄짜리")
                    Spacer()
                }
            }.padding(.top, 80.0)
                .padding(.leading, 15.0)
                .padding(.trailing, 15.0)
            ImageView(withURL: "https://cdn.pixabay.com/photo/2018/09/02/14/42/river-3648947_1280.jpg")
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
    }
}

struct AnswerComplete_EssayCamera: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                ImageView(withURL: "https://cdn.pixabay.com/photo/2018/09/02/14/42/river-3648947_1280.jpg")
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
                        QuestionView(text: "오늘 비가 와요.\n비를 주제로 사진과 함께\n한 줄 시를 써볼까요?")
                            .foregroundColor(Color.white)
                        Spacer()
                    }.padding(.leading, 15)
                        .padding(.bottom, 15)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 375.0)
            VStack {
                AnswerView(text: "종로3가 순두부 식당 맛있어보인다.\n갈지 말지 고민됨\n밖은 너무 추워보임...")
                    .multilineTextAlignment(.center)
                Spacer()
            }.padding(.top, 20)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.init(red: 216/255, green: 216/255, blue: 216/255))
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
    }
}

struct AnswerComplete_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AnswerComplete(answerMode: .essay)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max - Essay")

            AnswerComplete(answerMode: .camera)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max - Camera")

            AnswerComplete(answerMode: .essayCamera)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max - EssayCamera")
        }
    }
}
