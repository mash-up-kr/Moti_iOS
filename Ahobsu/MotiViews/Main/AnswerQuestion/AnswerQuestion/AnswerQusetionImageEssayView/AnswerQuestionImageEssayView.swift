//
//  AnswerQuestionImageEssayView.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/03/13.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerQuestionImageEssayView: View {
    @State var image: UIImage? = UIImage()
    @State var showCamera: Bool = false
    @State var isPresentImagePicker = false
    @State var text = ""
    var missonData: Mission
    
    var body: some View {
        NavigationMaskingView(titleItem: Text("답변하기")
                                .font(.system(size: 16)),
                              trailingItem: Button(action: {}, label: {
                                Text("완료")
                                    .foregroundColor(Color(.rosegold))
                                    .font(.system(size: 16))
                              })
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
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                            .clipped()
                            .onTapGesture {
                                self.isPresentImagePicker = true
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    
                    Color(.goldbrown)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                    Text(missonData.title)
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
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
        .sheet(isPresented: $isPresentImagePicker, content: {
            ImagePicker(showCamera: self.$showCamera,
                        image: self.$image,
                        isStatusBarHidden: .constant(false),
                        sourceType: .photoLibrary)
        })
    }
}

struct AnswerQuestionImageEssayView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerQuestionImageEssayView(missonData: Mission(id: 0,
                                                         title: "질문에 대한 \n답변을 해주세요",
                                                         isContent: true,
                                                         isImage: false))
    }
}
