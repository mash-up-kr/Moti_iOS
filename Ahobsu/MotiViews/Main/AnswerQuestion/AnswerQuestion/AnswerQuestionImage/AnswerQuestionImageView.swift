//
//  AnswerQuestionImageView.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/03/13.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerQuestionImageView: View {
    @State var image: UIImage? 
    @State var showCamera: Bool = false
    @State var showImagePicker = false
    @State var isStatusBarHidden = false
    @State var isPresentImagePicker = false
    @State var showImageSourcePicker = false
    @State var isLoading = false
    
    var missonData: Mission
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var answerRegisteredActive: Bool? = false
    @ObservedObject var answerQuestion = AnswerQuestion()
    
    var body: some View {
        NavigationMaskingView(titleItem: Text("답변하기")
                                .font(.system(size: 16)),
                              trailingItem: NavigationLink(destination: AnswerRegisteredView(),
                                                           tag: true,
                                                           selection: $answerRegisteredActive) {
                                Button(action: { self.requestAnswer() }) {
                                    Text("완료")
                                        .foregroundColor(image == nil ? Color(.gray) : Color(.rosegold))
                                        .font(.system(size: 16))
                                }
                              }
                              .disabled(image == nil)
        ) {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    ZStack {
                        Color.clear
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 4 / 3)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                self.showImageSourcePicker = true
                            }
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
                    .actionSheet(isPresented: $showImageSourcePicker) {
                        ActionSheet(title: Text("사진 선택하기"),
                                    message: nil,
                                    buttons: [.default(Text("카메라로 촬영하기"),
                                                       action: {
                                                        self.isStatusBarHidden = true
                                                        self.showCamera = true
                                                        self.isPresentImagePicker = true
                                    }),
                                              .default(Text("앨범에서 가져오기"),
                                                       action: {
                                                        self.isPresentImagePicker = true
                                              }),
                                              .cancel()])
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
                ActivityIndicator(isAnimating: $isLoading, style: .medium)
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
        isLoading = true
        AhobsuProvider.registerAnswer(missionId: missonData.id,
                                      contentOrNil: nil,
                                      imageOrNil: image,
                                      completion: { wrapper in
                                        print(wrapper?.data ?? "")
                                        isLoading = false
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
