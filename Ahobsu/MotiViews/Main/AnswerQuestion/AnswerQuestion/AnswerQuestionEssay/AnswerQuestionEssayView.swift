//
//  AnswerQuestionEssayView.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/03/13.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerQuestionEssayView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var text = ""
    @State var isLoading = false
    var missionData: Mission
    
    @State var answerRegisteredActive: Bool? = false
    @ObservedObject var answerQuestion = AnswerQuestion()
    
    var isEdit: Bool = false
    var answerId: Int? = nil
    
    private func getTitleItemString() -> String {
        if self.isEdit {
            return "수정 하기"
        } else {
            return "답변 하기"
        }
    }
    
    var body: some View {
        NavigationMaskingView(titleItem: Text(self.getTitleItemString())
                                .font(.system(size: 16)),
                              trailingItem: NavigationLink(destination: AnswerRegisteredView(),
                                                           tag: true,
                                                           selection: $answerRegisteredActive) {
                                Button(action: {
                                    if self.isEdit {
                                        self.updateAnswer()
                                    } else {
                                        self.requestAnswer()
                                    }
                                }) {
                                    Text("완료")
                                        .foregroundColor(text.isEmpty ? Color(.gray) : Color(.rosegold))
                                        .font(.system(size: 16))
                                }
                              }
                              .disabled(text.isEmpty)
        ) {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    Text(missionData.title)
                        .foregroundColor(Color(.rosegold))
                        .font(.custom("IropkeBatangOTFM", size: 20))
                        .lineSpacing(10.0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.all, 20)
                    
                    Image("imgAnswerdecoBar1")
                        .frame(height: 75)
                        .frame(maxWidth: .infinity)
                    
                    ZStack {
                        TextView(text: $text)
                        if text.isEmpty {
                            VStack {
                                Text("이곳에 질문에 대한 답변을 적어주세요.")
                                    .foregroundColor(Color(.placeholderblack))
                                    .font(.custom("IropkeBatangOTFM", size: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Spacer()
                            }
                            .padding(EdgeInsets(top: 9, leading: 5, bottom: 0, trailing: 0))
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 32, trailing: 20))
                }
                ActivityIndicator(isAnimating: $isLoading, style: .medium)
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
    }
    
    private func requestAnswer() {
        isLoading = true
        AhobsuProvider.registerAnswer(missionId: missionData.id,
                                      contentOrNil: text,
                                      imageOrNil: nil,
                                      completion: { wrapper in
                                        print(wrapper?.data ?? "")
                                        isLoading = false
                                        if let _ = wrapper?.data {
                                            self.answerRegisteredActive = true
//                                            self.answerRegisteredActive = 1
                                        } else {
                                            // print(wrapper?.message ?? "None")
                                        }
        }, error: { _ in
            
        }, expireTokenAction: {
            
        }, filteredStatusCode: nil)
    }
    
    private func updateAnswer() {
        guard let answerId = self.answerId else {
            return
        }
        
        isLoading = true
        AhobsuProvider.updateAnswer(answerId: answerId,
                                    missionId: missionData.id,
                                    contentOrNil: text,
                                    imageOrNil: nil,
                                    completion: { wrapper in
                                        isLoading = false
            if let _ = wrapper?.data {
                self.answerRegisteredActive = true
            } else {
                
            }
        }, error: { _ in
            
        }, expireTokenAction: {
            
        }, filteredStatusCode: nil)
    }
}

struct AnswerQuestionEssayView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerQuestionEssayView(missionData: Mission(id: 0,
                                                    title: "질문에 대한 \n답변을 해주세요",
                                                    isContent: true,
                                                    isImage: false))
    }
}
