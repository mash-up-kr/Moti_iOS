//
//  AlbumView.swift
//  Ahobsu
//
//  Created by 한종호 on 28/01/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct AlbumView: View {
    var body: some View {
         NavigationView {
            ZStack {
                BackgroundView()
                    .edgesIgnoringSafeArea([.vertical])
                ScrollView {
                    Text("Hi")
                }
            }
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView()
    }
}
