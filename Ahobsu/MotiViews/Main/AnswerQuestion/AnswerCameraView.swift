//
//  AnswerInsertCameraView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/12/21.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerCameraView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var showImagePicker: Bool = false
    @State var image: UIImage?
    
    var missonData: Mission
    @State var isNetworking: Bool = false
    
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
                    
                    NavigationLink(destination: AnswerInsertCamaraView(image: $image)) {
                        MainButton(action: {
                            if self.image == nil {
                                self.showImagePicker = true
                            } else {
                                self.registerCameraAnswer()
                            }},
                                   title: image == nil ? "촬영하기" : "제출하기")
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
        AhobsuProvider.provider.request(.registerAnswer(missionId: missonData.id,
                                                        contentOrNil: nil,
                                                        imageOrNil: image),
                                        completionHandler: { (response) in
                                            defer {
                                                self.isNetworking = false
                                            }
                                            if response.statusCode == 201 {
                                                self.presentationMode.wrappedValue.dismiss()
                                            } else {
                                                
                                            }
        },
                                        errorHandler: { (error) in
                                            self.isNetworking = false
        })
    }
}

struct AnswerCameraView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerCameraView(missonData: Mission(id: 1, title: "", isContent: true, isImage: true))
    }
}
