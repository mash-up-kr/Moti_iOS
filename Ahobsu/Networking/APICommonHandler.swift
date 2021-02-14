//
//  APICommonHandler.swift
//  Ahobsu
//
//  Created by Hochan Lee on 2021/02/15.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import Foundation
import Moya

final class APICommonHandler {
    private init() {}
    
    static func forceUpdate(response: Response) {
        guard let errorCodeMsg = try? response.map(ErrorCodeMsg.self) else { return }
        
        switch errorCodeMsg.code {
        case AhobsuProvider.StatusEnum.value(.token_invalid)():
            break
            
        case AhobsuProvider.StatusEnum.value(.forceUpdate)():
            break
        default:
            break
        }
    }
}
