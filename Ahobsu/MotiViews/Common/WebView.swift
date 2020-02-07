//
//  WebView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/02/05.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
    
}

#if DEBUG
struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "https://www.apple.com")!)
    }
}
#endif
