//
//  AnswerQuestionImageView.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/03/13.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerQuestionImageView: View {
    @State var image: UIImage? = UIImage()
    @State var showCamera: Bool = false
    @State var isPresentImagePicker = false
    var missonData: Mission
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var answerRegisteredActive: Bool = false
    @ObservedObject var answerQuestion = AnswerQuestion()
    
    var body: some View {
        NavigationMaskingView(titleItem: Text("답변하기")
                                .font(.system(size: 16)),
                              trailingItem: NavigationLink(destination: AnswerRegisteredView(),
                                                           isActive: $answerRegisteredActive) {
                                Button(action: { self.requestAnswer() }) {
                                    Text("완료")
                                        .foregroundColor(Color(.rosegold))
                                        .font(.system(size: 16))
                                }
//                                .disabled(true)
                              }
        ) {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    ZStack {
                        Image("icCameraIncircle")
                        Image(uiImage: image ?? UIImage())
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 4 / 3)
                            .allowsHitTesting(false)
                            .clipped()
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 4 / 3)
                    .clipped()
                    .onTapGesture {
                        self.isPresentImagePicker = true
                    }

                    Color(.goldbrown)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                    Text(missonData.title)
                        .foregroundColor(Color(.rosegold))
                        .font(.custom("IropkeBatangOTFM", size: 20))
                        .lineSpacing(10.0)
                        .frame(height: 124, alignment: .topLeading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.all, 20)
                }
                .ignoresSafeArea(.all, edges: .bottom)
            }
        }
        .sheet(isPresented: $isPresentImagePicker, content: {
            ImagePicker(showCamera: self.$showCamera,
                        image: self.$image,
                        isStatusBarHidden: .constant(false),
                        sourceType: .photoLibrary)
        })
    }
    
    private func requestAnswer() {
        AhobsuProvider.registerAnswer(missionId: missonData.id,
                                      contentOrNil: nil,
                                      imageOrNil: image,
                                      completion: { wrapper in
                                        print(wrapper?.data ?? "")
                                        if let _ = wrapper?.data {
                                            self.answerRegisteredActive = true
                                        } else {
                                            // print(wrapper?.message ?? "None")
                                        }
        }, error: { _ in
            
        }, expireTokenAction: {
            
        }, filteredStatusCode: nil)
    }
}

struct AnswerQuestionImageView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerQuestionImageView(missonData: Mission(id: 0,
                                                    title: "질문에 대한 \n답변을 해주세요",
                                                    isContent: false,
                                                    isImage: true))
    }
}
