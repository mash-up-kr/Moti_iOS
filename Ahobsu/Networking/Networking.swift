//
//  Networking.swift
//  Ahobsu
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Moya
import Combine

typealias AhobsuNetworking = Networking<AhobsuAPI>

final class Networking<Target: TargetType>: MoyaProvider<Target> {
    
    init(plugins: [PluginType] = []) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 10
        
        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        super.init(manager: manager, plugins: plugins)
    }
    
    func requestPublisher(_ target: Target, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<Response, MoyaError> {
        return MoyaPublisher { [weak self] subscriber in
            return self?.request(target, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    _ = subscriber.receive(response)
                    subscriber.receive(completion: .finished)
                case let .failure(error):
                    subscriber.receive(completion: .failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    @discardableResult
    func request(
        _ target: Target,
        completionHandler: @escaping (Response) -> Void,
        errorHandler: @escaping (MoyaError) -> Void
    ) -> Moya.Cancellable {
        return self.request(target) { result in
            switch result {
            case let .success(response):
                completionHandler(response)
            case let .failure(error):
                if let response = error.response {
                    if let _ = try? response.mapJSON(failsOnEmptyData: false) {
                        // print(jsonObject)
                    } else if let _ = String(data: response.data, encoding: .utf8) {
                        // print(rawString)
                    }
                }
                errorHandler(error)
            }
        }
    }
}
