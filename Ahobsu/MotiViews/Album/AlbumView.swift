//
//  AlbumView.swift
//  Ahobsu
//
//  Created by 한종호 on 28/01/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct AlbumView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var btnBack : some View {
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
    
    var body: some View {
         NavigationView {
             ZStack {
                 BackgroundView()
                    .edgesIgnoringSafeArea([.vertical])
                 VStack {
                     Text("Hi")
                 }
                 .navigationBarItems(leading: btnBack)
                 .navigationBarBackButtonHidden(true)
                 .navigationBarTitle(Text("앨범")
                 .font(.custom("AppleSDGothicNeo-Regular", size: 16.0)), displayMode: .inline)
                 .background(NavigationConfigurator { navConfig in
                     navConfig.navigationBar.barTintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
                     navConfig.navigationBar.titleTextAttributes = [
                         .foregroundColor: UIColor.rosegold
                     ]
                 })
             }
             .navigationViewStyle(StackNavigationViewStyle())
         }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView()
    }
}
