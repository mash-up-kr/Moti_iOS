//
//  AnswerComplete.swift
//  Ahobsu
//
//  Created by 김선재 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//
import SwiftUI

extension String {
    static func toAnswerCompleteDateString(from date: Date) -> String {
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        let monthEnum = MonthEnum(month: month)
        let returnStr = "\(year). \(monthEnum.longMonthString()). \(day)"
        
        return returnStr
    }
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
    
    var models: [Answer]
    
    @State var currentPage = 0
    
    init(models: [Answer]) {
        self.models = models
        
        self.viewControllers = self.models.map({
            let controller = UIHostingController(rootView: AnswerCompleteCardView(answer: $0))
            
            controller.view.backgroundColor = UIColor.clear
            
            return controller
        })
    }
    
    func getTodayDateString() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFullDate
        formatter.timeZone = TimeZone.current
        
        let nowDate = Date()
        let modifiedDate = Calendar.current.date(byAdding: .hour, value: -MISSION_INIT_TIME.hour, to: nowDate)!
        
        let todayDateString = formatter.string(from: modifiedDate)
        return todayDateString
    }
    
    func isEditable(currentAnswer: Answer) -> Bool {
        return currentAnswer.date == self.getTodayDateString()
    }
    
    var btnBack: some View {
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
    
    @ViewBuilder
    var btnEdit: some View {
        let currentAnswer = self.models[self.currentPage]
        
        if self.isEditable(currentAnswer: currentAnswer) {
            Button(action: {}, label: {
                HStack {
                    if currentAnswer.getAnswerType() == Answer.AnswerType.essay {
                        NavigationLink(destination: AnswerQuestionEssayView(
                                        text: currentAnswer.content ?? "",
                            missionData: currentAnswer.mission,
                                        isEdit: true,
                                        answerId: currentAnswer.id
                        )) {
                            Image("icRewriteNormal")
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                        }.environment(\.isEnabled, !currentAnswer.mission.title.isEmpty)
                    }
                    
                    if currentAnswer.getAnswerType() == Answer.AnswerType.camera {
                        NavigationLink(destination: AnswerQuestionImageView(
                            image: UIImage(data: ImageLoader(urlString: currentAnswer.imageUrl ?? "").data ?? Data()),
                            missionData: currentAnswer.mission,
                                        isEdit: true,
                                        answerId: currentAnswer.id,
                                        imageUrl: currentAnswer.imageUrl
                        )) {
                            Image("icRewriteNormal")
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                        }.environment(\.isEnabled, !currentAnswer.mission.title.isEmpty)
                    }
                    
                    if currentAnswer.getAnswerType() == Answer.AnswerType.essayCamera {
                        NavigationLink(destination: AnswerQuestionImageEssayView(
                            image: UIImage(data: ImageLoader(urlString: currentAnswer.imageUrl ?? "").data ?? Data()),
                                        text: currentAnswer.content ?? "",
                            missionData: currentAnswer.mission,
                                        isEdit: true,
                            answerId: currentAnswer.id,
                            imageUrl: currentAnswer.imageUrl
                        )) {
                            Image("icRewriteNormal")
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                        }.environment(\.isEnabled, !currentAnswer.mission.title.isEmpty)
                    }
                }
            })
        }
        else {
            EmptyView()
        }
    }
    
    var body: some View {
        NavigationMaskingView(titleItem: {
            Text(dateToString(models[currentPage].dateForDate))
                .foregroundColor(Color(.rosegold))
                .font(.custom("IropkeBatangOTFM", size: 20.0))
                .lineSpacing(16.0)
        }(), trailingItem: btnEdit) {
            ZStack {
                BackgroundView()
                    .edgesIgnoringSafeArea([.vertical])
                ZStack {
                    SwiftUIPagerView(spacing: 0,
                                     pageWidthCompensation: 0,
                                     index: $currentPage,
                                     pages: models.map { AnswerCompleteCardView(answer: $0) })
                        .disabled(models.count == 1)
                    if models.count != 1 {
                        VStack {
                            Spacer()
                            AnswerCompletePageControl(numberOfPages: viewControllers.count,
                                                      currentPage: $currentPage)
                            Spacer()
                                .frame(height: 20)
                        }
                    }
                }
            }
        }
    }
    
    func dateToString(_ date: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date ?? Date())
    }
}

struct AnswerCompleteView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        return Group {
            AnswerCompleteView(models: Answer.dummyCardView())
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
        }
    }
}
