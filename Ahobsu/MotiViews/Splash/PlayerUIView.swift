//
//  PlayerUIView.swift
//  Ahobsu
//
//  Created by admin on 20/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI
import AVFoundation

class PlayerUIView: UIView {
  private let playerLayer = AVPlayerLayer()
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let url = Bundle.main.url(forResource: "video", withExtension: "mp4")!
    let player = AVPlayer(url: url)
    player.play()
    
    playerLayer.player = player
    layer.addSublayer(playerLayer)
  }
    
  required init?(coder: NSCoder) {
   fatalError("init(coder:) has not been implemented")
  }
    
  override func layoutSubviews() {
    super.layoutSubviews()
    playerLayer.frame = bounds
  }
}
