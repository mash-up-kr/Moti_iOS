//
//  AnswerInsertEssayView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/12/21.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct AnswerInsertEssayView: View {
    @State var text = "sadasjdkaljdlajd\ndsifsifha\nasdufhuah\nsdhfusadh\nsfjslijfsladj"
    var missonData: MissionData
    @ObservedObject var keyboard: Keyboard = Keyboard()

    var body: some View {
        ZStack {
            BackgroundView()
                .edgesIgnoringSafeArea([.vertical])
            ZStack {
                VStack {
                    HStack {
                        Text(missonData.title)
                            .font(.system(size: 24))
                            .lineSpacing(6)
                            .foregroundColor(Color(.rosegold))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    Spacer()
                    ZStack {
                        MainCardView(isWithLine: true)
                            .padding([.horizontal], 12)
                            .offset(x: 0, y: 60)
                        VStack {
                            TextView(text: $text)
                                .padding(EdgeInsets(top: 150 + 28,
                                                    leading: 28,
                                                    bottom: 32,
                                                    trailing: 28))

                            //                            .padding([.horizontal], 28)
                            Spacer()
                            MainButton(title: "제출하기")
                            Spacer().frame(height: 32)
                        }
                    }
                }
                .padding([.horizontal], 20)
            }

                //            .padding([.bottom], keyboard.state.height)
                .offset(x: 0, y: keyboard.state.height == 0 ? keyboard.state.height : -keyboard.state.height)
                .edgesIgnoringSafeArea((keyboard.state.height > 0) ? [.bottom] : [])
                .animation(.easeOut(duration: keyboard.state.animationDuration))

        }

        .onTapGesture {
            self.endEditing()
        }

    }

    private func endEditing() {
        UIApplication.shared.endEditing()
    }

}

struct AnswerInsertEssayView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerInsertEssayView(missonData: MissionData(id: 1, title: "", isContent: true, isImage: true))
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {

        let myTextView = UITextView()
        myTextView.delegate = context.coordinator

        myTextView.font = .systemFont(ofSize: 16)
        myTextView.textAlignment = .center
        myTextView.textColor = .rosegold
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.backgroundColor = .clear

        return myTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    class Coordinator: NSObject, UITextViewDelegate {

        var parent: TextView

        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
        }
    }
}
