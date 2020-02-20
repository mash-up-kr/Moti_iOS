//
//  PlayerView.swift
//  Ahobsu
//
//  Created by admin on 20/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI

struct PlayerView: UIViewRepresentable {
  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
  }
  func makeUIView(context: Context) -> UIView {
    return PlayerUIView(frame: .zero)
  }
}
