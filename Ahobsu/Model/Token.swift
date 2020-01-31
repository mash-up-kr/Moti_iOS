//
//  RefreshToken.swift
//  Ahobsu
//
//  Created by 한종호 on 01/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

struct Token: Decodable {
    var accessToken: String
    var refreshToken: String
    var signUp: Bool

  enum CodingKeys: String, CodingKey {
    case accessToken
    case refreshToken
    case signUp
  }
}
