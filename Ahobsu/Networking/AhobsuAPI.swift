
//
//  AhobsuAPI.swift
//  Ahobsu
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Moya

enum AhobsuAPI {
    case test
    case testPost(id: Int, data: String)
}

extension AhobsuAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: AHOBSU_API_URL)
            else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .test:
            return "/"
        case let .testPost(id):
            return "/\(id)"
        }
    }
    
    var method: Method {
        switch self {
        case .test:
            return .get
        case .testPost:
            return .post
        }
    }
    
    var sampleData: Data {
        return .init()
    }
    
    var params: [String: Any] {
        var defaultParams: [String: Any] = [:]
        
        switch self {
        case let .testPost(id, data):
            defaultParams["id"] = id
            defaultParams["data"] = data
            
        default:
            break
        }
        
        return defaultParams
    }
    
    var task: Task {
        switch self {
        case .testPost:
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding(arrayEncoding: .noBrackets))
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
    
}
