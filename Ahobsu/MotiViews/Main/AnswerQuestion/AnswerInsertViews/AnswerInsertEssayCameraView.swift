//
//  AnswerInsertEssayCameraView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2020/02/09.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerInsertEssayCameraView: View {
    @Binding var image: UIImage?
    
    @ObservedObject var keyboard: Keyboard = Keyboard()
    @ObservedObject var answerQuestion = AnswerQuestion()
    
    @State var text = ""
    
    var missionData: Mission
    @State var isNetworking: Bool = false
    @State var answerRegisteredActive: Bool = false
    
    var body: some View {
        NavigationMaskingView(titleItem: Text("답변하기"), trailingItem: EmptyView()) {
            ZStack {
                BackgroundView()
                    .edgesIgnoringSafeArea([.vertical])
                ZStack {
                    VStack {
                        HStack {
                            Text(missionData.title)
                                .font(.custom("IropkeBatangOTFM", size: 24.0))
                                .lineSpacing(6)
                                .foregroundColor(Color(.rosegold))
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        Spacer()
                        ZStack {
                            CardView(innerLine: true)
                                .padding([.horizontal], 12)
                                .offset(x: 0, y: 60)
                            VStack {
                                Image(uiImage: image ?? UIImage())
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fill)
                                    .cornerRadius(6)
                                    .padding(.horizontal, 34)
//                                    .padding(.vertical, 22)
//                                ZStack {
                                    
                                    if text == "" && keyboard.state.height == 0 {
                                        VStack {
                                            Text("여기를 눌러 질문에 대한\n답을 적어주세요.")
                                                .font(.custom("IropkeBatangOTFM", size: 16.0))
                                                .lineSpacing(8.0)
                                                .foregroundColor(Color(.placeholderblack))
                                                .multilineTextAlignment(.center)
                                                .padding(EdgeInsets(top: 100 + (keyboard.state.height == 0 ? 100 : -100 + keyboard.state.height),
                                                                    leading: 28,
                                                                    bottom: 32,
                                                                    trailing: 28))
                                            Spacer()
                                        }
                                    }
                                    TextView(text: $text)
                                        .padding(EdgeInsets(top: 100 + (keyboard.state.height == 0 ? 100 : -100 + keyboard.state.height),
                                                            leading: 28,
                                                            bottom: 32,
                                                            trailing: 28))
//                                }
                                Spacer()
                                NavigationLink(destination: AnswerRegisteredView(),
                                               isActive: $answerRegisteredActive)
                                {
                                    MainButton(action: { self.requestAnswer() },
                                               title: "제출하기")
                                }
                                Spacer().frame(height: 32)
                            }
                        }
                    }
                    .padding([.horizontal], 20)
                }
                .offset(x: 0, y: keyboard.state.height == 0 ? keyboard.state.height : -keyboard.state.height)
                .edgesIgnoringSafeArea((keyboard.state.height > 0) ? [.bottom] : [])
                .animation(.easeOut(duration: keyboard.state.animationDuration))
            }
            .onTapGesture {
                self.endEditing()
                
            }
        }
    }
    
    private func requestAnswer() {
        guard let image = image else { return }
        self.isNetworking = true
        
        AhobsuProvider.registerAnswer(missionId: missionData.id,
                                      contentOrNil: text,
                                      imageOrNil: image,
                                      completion: { wrapper in
                                        if let _ = wrapper?.data {
                                          self.answerRegisteredActive = true
                                        } else {
                                            // print(wrapper?.message ?? "None")
                                        }
                                        
                                        self.isNetworking = false
        }, error: { _ in
            self.isNetworking = false
        }, expireTokenAction: {
            
        }, filteredStatusCode: nil)
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

//struct AnswerInsertEssayCameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnswerInsertEssayCameraView()
//    }
//}
