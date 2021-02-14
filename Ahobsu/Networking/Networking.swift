//
//  Networking.swift
//  Ahobsu
//
//  Created by 김선재 on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Moya
import Combine
import Alamofire

typealias AhobsuNetworking = Networking

final class Networking: MoyaProvider<AhobsuAPI> {
    
    init(plugins: [PluginType] = []) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 50
        
        super.init(endpointClosure: Self.endpointClosure,
                   session: DefaultAlamofireSession.sharedSession)
    }
    
    private static let endpointClosure = { (target: AhobsuAPI) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        return defaultEndpoint
    }
    
    func requestPublisher(_ target: AhobsuAPI, callbackQueue: DispatchQueue? = nil) -> AnyPublisher<Response, MoyaError> {
        return MoyaPublisher { [weak self] subscriber in
            return self?.request(target, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    APICommonHandler.handleError(response)
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
        _ target: AhobsuAPI,
        completionHandler: @escaping (Response) -> Void,
        errorHandler: @escaping (MoyaError) -> Void
    ) -> Moya.Cancellable {
        return self.request(target) { result in
            switch result {
            case let .success(response):
                APICommonHandler.handleError(response)
                
                completionHandler(response)
            case let .failure(error):
                if let response = error.response {
                    print(response)
                    if let _ = try? response.mapJSON(failsOnEmptyData: false) {
//                         print(jsonObject)
                    } else if let _ = String(data: response.data, encoding: .utf8) {
                        // print(rawString)
                    }
                }
                errorHandler(error)
            }
        }
    }
}

final class DefaultAlamofireSession: Session {
    static let sharedSession: DefaultAlamofireSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Session.default.session.configuration.httpAdditionalHeaders
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 50
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireSession(configuration: configuration)
    }()
}
