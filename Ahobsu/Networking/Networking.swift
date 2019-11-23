//
//  Networking.swift
//  Ahobsu
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Moya

typealias AhobsuNetworking = Networking<AhobsuAPI>

final class Networking<Target: TargetType>: MoyaProvider<Target> {
    
    init(plugins: [PluginType] = []) {
        let manager = Manager(configuration: AHOBSU_API_CONFIGURATION)
        manager.startRequestsImmediately = false
        super.init(manager: manager, plugins: plugins)
    }
    
    @discardableResult
    func request(
        _ target: Target,
        completionHandler: @escaping (Response) -> Void,
        errorHandler: @escaping (MoyaError) -> Void
    ) -> Cancellable {
        
        return self.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    completionHandler(filteredResponse)
                }
                catch {
                    errorHandler(MoyaError.statusCode(response))
                }
            case let .failure(error):
                if let response = error.response {
                    if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                        print (jsonObject)
                    } else if let rawString = String(data: response.data, encoding: .utf8) {
                        print (rawString)
                    }
                }
                errorHandler(error)
            }
        }
    }
}
