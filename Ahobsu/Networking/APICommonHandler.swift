//
//  APICommonHandler.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/02/15.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import UIKit
import SwiftUI
import Moya

final class APICommonHandler {
    private init() {}
    
    static func handleError(_ response: Response) {
        guard let errorCodeMsg = try? response.map(ErrorCodeMsg.self) else { return }
        
        switch errorCodeMsg.code {
        case AhobsuProvider.StatusEnum.value(.token_invalid)():
            Self.forceLogout()
        case AhobsuProvider.StatusEnum.value(.forceUpdate)():
            Self.forceUpdate()
        default:
            break
        }
    }
    
    private static func forceLogout() {
        guard let window = (UIApplication.shared.windows.first { $0.tag == -1 }) else { return }
        window.rootViewController = UIHostingController(rootView: SignInView(window: window))
    }
    
    static func forceUpdate() {
        var targetViewController = UIApplication.shared.windows.first { $0.tag == -1 }?.rootViewController
        while targetViewController?.presentedViewController != nil {
            targetViewController = targetViewController?.presentedViewController
        }
        
        let alert = UIAlertController(title: "앱의 지속적인 사용을 위해 업데이트가 필요합니다.", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            let scheme = "itms-apps://itunes.apple.com/app/id1496912171?mt=8"
            guard let schemeStr = scheme.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                let url = URL(string: schemeStr) else { return }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, completionHandler: nil)
            }
        }
        
        alert.addAction(ok)
        targetViewController?.present(alert, animated: true, completion: nil)
    }
}
