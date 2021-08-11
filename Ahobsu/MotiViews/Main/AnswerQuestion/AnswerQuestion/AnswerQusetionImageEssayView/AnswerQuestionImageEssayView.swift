//
//  AnswerQuestionImageEssayView.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/03/13.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerQuestionImageEssayView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var image: UIImage?
    @State var showCamera: Bool = false
    @State var showImagePicker = false
    @State var isStatusBarHidden = false
    @State var isPresentImagePicker = false
    @State var showImageSourcePicker = false
    @State var text = ""
    @State var isLoading = false
    
    var missionData: Mission
    
    @State var answerRegisteredActive: Bool? = false
    @ObservedObject var answerQuestion = AnswerQuestion()
    
    var isEdit: Bool = false
    var answerId: Int? = nil
    var imageUrl: String? = nil
    
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
                                        .foregroundColor((isEdit ? text.isEmpty : text.isEmpty || image == nil) ? Color(.gray) : Color(.rosegold))
                                        .font(.system(size: 16))
                                }
                              }
                              .disabled(isEdit ? text.isEmpty : text.isEmpty || image == nil)
        ) {
            ZStack {
                BackgroundView()
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    ZStack {
                        Color.clear
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                self.showImageSourcePicker = true
                            }
                        Image("icCameraIncircle")
                        if let image = self.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width, height: 200)
                                .allowsHitTesting(false)
                                .clipped()
                        } else if let imageUrl = self.imageUrl {
                            ImageView(withURL: imageUrl)
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width, height: 200)
                                .allowsHitTesting(false)
                                .clipped()
                        }
                    }
                    .foregroundColor(.blue)
                    .frame(width: UIScreen.main.bounds.width, height: 200)
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
                            .frame(minHeight: 300)
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
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
                ActivityIndicator.init(isAnimating: $isLoading, style: .medium)
            }
        }
        .sheet(isPresented: $isPresentImagePicker, content: {
            ImagePicker(showCamera: self.$showCamera,
                        image: self.$image,
                        isStatusBarHidden: self.$isStatusBarHidden,
                        sourceType: .photoLibrary)
        })
    }
    
    private func requestAnswer() {
        isLoading = true
        AhobsuProvider.registerAnswer(missionId: missionData.id,
                                      contentOrNil: text,
                                      imageOrNil: image,
                                      completion: { wrapper in
                                        isLoading = false
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
    
    private func updateAnswer() {
        guard let answerId = self.answerId else {
            return
        }
        
        isLoading = true
        AhobsuProvider.updateAnswer(answerId: answerId,
                                    missionId: missionData.id,
                                    contentOrNil: text,
                                    imageOrNil: image,
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

struct AnswerQuestionImageEssayView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerQuestionImageEssayView(missionData: Mission(id: 0,
                                                         title: "질문에 대한 \n답변을 해주세요",
                                                         isContent: true,
                                                         isImage: false)
        )
    }
}
