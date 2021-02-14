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
            break
        default:
            break
        }
    }
    
    private static func forceLogout() {
        guard let window = (UIApplication.shared.windows.first { $0.tag == -1 }) else { return }
        window.rootViewController = UIHostingController(rootView: SignInView(window: window))
    }
}
