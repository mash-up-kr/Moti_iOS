//
//  AnswerComplete.swift
//  Ahobsu
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

enum AnswerMode {
    case essay
    case camera
    case essayCamera
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(
        _ uiViewController: UIViewController,
        context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let ncv = uiViewController.navigationController {
            self.configure(ncv)
        }
    }
}

struct AnswerCompleteView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var answerMode: AnswerMode
    @State var currentPage: Int

    //    var contentView: some View {
    //        switch answerMode {
    //        case .essay:
    //            return AnyView(AnswerComplete_Essay())
    //        case .camera:
    //            return AnyView(AnswerComplete_Camera())
    //        case .essayCamera:
    //            return AnyView(AnswerComplete_EssayCamera())
    //        }
    //    }

    var btnBack : some View {
        Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }, label: {
            HStack {
                Image("icArrowLeft") // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
        })
    }

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                    .edgesIgnoringSafeArea([.vertical])
                ScrollView {
                    VStack {
                        AnswerCompletePageControl(numberOfPages: 7,
                                    currentPage: $currentPage)
                            .padding(.bottom, 16.0)
                        HStack {
                            Text("해커톤이 끝났어요.\n지금 기분으로\n글을 써볼까요?")
                                .font(.custom("Baskerville", size: 24.0))
                                .foregroundColor(Color(UIColor.rosegold))
                                .lineSpacing(12.0)
                            Spacer()
                            Button(action: update) {
                                Image("icRewriteNormal")
                                    .renderingMode(.original)
                                    .frame(width: 48.0, height: 48.0)
                            }
                        }
                        .padding([.leading], 20.0)
                        .padding([.trailing], 4.0)
                        Spacer()
                    }
                }
            }
            .navigationBarItems(leading: btnBack)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle(
                    Text("2019. Nov. 21")
                        .font(.custom("Baskerville", size: 24.0)), displayMode: .inline
            )
            .background(NavigationConfigurator { navConfig in
                navConfig.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
                navConfig.navigationBar.titleTextAttributes = [
                    .foregroundColor: UIColor.rosegold
                ]
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func update() {

    }
}

struct AnswerCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AnswerCompleteView(answerMode: .essay, currentPage: 0)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max - Essay")

            //            AnswerCompleteView(answerMode: .camera)
            //                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            //                .previewDisplayName("iPhone 11 Pro Max - Camera")
            //
            //            AnswerCompleteView(answerMode: .essayCamera)
            //                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            //                .previewDisplayName("iPhone 11 Pro Max - EssayCamera")
        }
    }
}
