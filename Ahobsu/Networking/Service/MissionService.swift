//
//  MissionService.swift
//  Ahobsu
//
//  Created by admin on 2019/11/24.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Moya

protocol MissionServiceType {
  func getMissions(completion: @escaping (Result<Mission, MoyaError>) -> Void)
}

final class MissionService: MissionServiceType {
  private let networking: AhobsuNetworking

  init(networking: AhobsuNetworking) {
    self.networking = networking
  }

  func getMissions(completion: @escaping (Result<Mission, MoyaError>) -> Void) {
    self.networking.request(
        .mission,
      completionHandler: { response in
        completion(response.decodeJSON(Mission.self))
      }, errorHandler: { error in
        completion(.failure(error))
      })
  }
}

extension Response {
  func decodeJSON<D: Decodable>(_ type: D.Type) -> Result<D, MoyaError> {
    do {
      return .success(try self.map(D.self))
    } catch let err {
      return .failure(MoyaError.objectMapping(err, self))
    }
  }
}
