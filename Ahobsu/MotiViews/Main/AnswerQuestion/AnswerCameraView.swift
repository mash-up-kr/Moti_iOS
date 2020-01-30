//
//  AnswerInsertCameraView.swift
//  Ahobsu
//
//  Created by 이호찬 on 2019/12/21.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import SwiftUI

struct AnswerCameraView: View {
    var missonData: MissionData
    @State var showImagePicker: Bool = false
    @State var image: UIImage?
    var body: some View {
        ZStack {
            BackgroundView()
                .edgesIgnoringSafeArea([.vertical])
            VStack {
                HStack {
                    Text("오늘 먹은 음식을 \n사진으로 남겨볼까요?")
                        .font(.system(size: 24))
                        .lineSpacing(6)
                        .foregroundColor(Color(.rosegold))
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
                Image("imgCam")
                Spacer()
                
                NavigationLink(destination: AnswerInsertCamaraView(image: image)) {
                    MainButton(action: {
                        self.showImagePicker = true
                    }, title: "촬영하기")
                }
                    
                .sheet(isPresented: self.$showImagePicker,
                       onDismiss: {
                        
                        print(self.image) },
                       content: {
                        ImagePicker(image: self.$image) }
                        
                )
                
                    
                
                Spacer()
            }
            .padding([.horizontal], 20)
        }
    }
}

struct AnswerCameraView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerCameraView(missonData: MissionData(id: 1, title: "", isContent: 1, isImage: 1))
    }
}
