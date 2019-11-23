//
//  AhobsuProvider.swift
//  Ahobsu
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Moya

class AhobsuProvider {
    static let provider = AhobsuNetworking()

    class func test(completion: @escaping ((Response) -> Void),
                    error: @escaping ((MoyaError) -> Void)) {
        provider.request(.test, completionHandler: completion, errorHandler: error)
    }

    class func testPost(postId: Int,
                        data: String,
                        completion: @escaping ((Response) -> Void),
                        error: @escaping ((MoyaError) -> Void)) {
        provider.request(.testPost(postId: postId, data: data), completionHandler: completion, errorHandler: error)
    }

    class func mission(completion: @escaping ((Response) -> Void),
                       error: @escaping ((MoyaError) -> Void)) {
        provider.request(.mission, completionHandler: completion, errorHandler: error)
    }
}
