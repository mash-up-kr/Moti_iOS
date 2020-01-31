//
//  APIData.swift
//  Ahobsu
//
//  Created by 한종호 on 01/02/2020.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

struct APIData<T : Decodable>: Decodable {
    let status: Int
    let message: String
    let data: T

  enum CodingKeys: String, CodingKey {
    case status
    case message
    case data
  }
}
