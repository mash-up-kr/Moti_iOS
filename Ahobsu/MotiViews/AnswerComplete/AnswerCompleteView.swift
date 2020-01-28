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

    var viewControllers: [UIHostingController<AnswerCompleteCardView>]

    var models: [AnswerCompleteModel]

    @State var currentPage = 0

    init(_ model: [AnswerCompleteModel]) {
        self.models = model

        self.viewControllers = model.map({
            let controller = UIHostingController(rootView: AnswerCompleteCardView(answerCompleteModel: $0))

            controller.view.backgroundColor = UIColor.clear

            return controller
        })
    }

    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            HStack {
                Image("icArrowLeft")
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
                VStack {
                    AnswerCompletePageControl(numberOfPages: viewControllers.count,
                                              currentPage: $currentPage)
                        .padding(.bottom, 16.0)
                    PageViewController(controllers: viewControllers, currentPage: $currentPage)
                }
                .navigationBarItems(leading: btnBack)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle(Text(models[currentPage].date)
                .font(.custom("IropkeBatangM", size: 24.0)), displayMode: .inline)
                .background(NavigationConfigurator { navConfig in
                    navConfig.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
                    navConfig.navigationBar.titleTextAttributes = [
                        .foregroundColor: UIColor.rosegold
                    ]
                })
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct AnswerCompleteView_Previews: PreviewProvider {

    static var previews: some View {

        return Group {
            AnswerCompleteView(AnswerCompleteModel.dummyCardView())
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}
