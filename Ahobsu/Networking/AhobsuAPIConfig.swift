//
//  AhobsuAPIConfig.swift
//  Ahobsu
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

let AHOBSU_API_URL = "https://localhost"

let AHOBSU_API_CONFIGURATION = URLSessionConfiguration.default
AHOBSU_API_CONFIGURATION.httpAdditionalHeaders = Manager.defaultHTTPHeaders
AHOBSU_API_CONFIGURATION.timeoutIntervalForRequest = 10
