//
//  AnswerInsertCameraView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/12/21.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerCameraView: View {
    
    @State var showImagePicker: Bool = false
    @State var image: UIImage?
    
    var missonData: Mission
    @State var isNetworking: Bool = false
    @State var answerRegisteredActive: Bool = false
    
    var body: some View {
        NavigationMaskingView(titleItem: Text("답변하기"), trailingItem: EmptyView()) {
            ZStack {
                BackgroundView()
                    .edgesIgnoringSafeArea([.vertical])
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
                    if image != nil {
                        MainCardView(isWithLine: true)
                            .overlay(Image(uiImage: image!)
                                .resizable()
                                .padding(.horizontal, 34)
                                .padding(.vertical, 22))
                            .padding(32)
                    } else {
                        Image("imgCam")
                    }
                    Spacer()
                    HStack {
                        if self.image == nil {
                            NavigationLink(destination: AnswerInsertCamaraView(image: $image))
                            {
                                MainButton(action: { self.showImagePicker = true },
                                           title: "촬영하기")
                            }
                        } else {
                            NavigationLink(destination: AnswerRegisteredView(),
                                           isActive: $answerRegisteredActive)
                            {
                                MainButton(action: { self.registerCameraAnswer() },
                                           title: "제출하기")
                            }
                        }
                        
                    }
                    .environment(\.isEnabled, !isNetworking)
                    .sheet(isPresented: self.$showImagePicker,
                           onDismiss: {
                            // print(self.image ?? UIImage())
                    },
                           content: {
                            ImagePicker(image: self.$image) }
                        
                    )
                    Spacer(minLength: 32)
                }
                .padding([.horizontal], 20)
            }
        }
    }
}

extension AnswerCameraView {
    func registerCameraAnswer() {
        guard let image = image else { return }
        self.isNetworking = true
        AhobsuProvider.registerAnswer(missionId: missonData.id,
                                      contentOrNil: nil,
                                      imageOrNil: image,
                                      completion: { (response) in
                                        self.isNetworking = false
                                        if let _ = response?.data {
                                            self.answerRegisteredActive = true
                                        }},
                                      error: { (error) in
                                        self.isNetworking = false },
                                      expireTokenAction: {
                                        self.isNetworking = false },
                                      filteredStatusCode: nil)
    }
}

struct AnswerCameraView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerCameraView(missonData: Mission(id: 1, title: "", isContent: true, isImage: true))
    }
}
