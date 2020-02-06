//
//  AppVersion.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/01/29.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation
import Combine

struct AppVersion {
    var latestVersion: String
    var currentVersion: String
    
}

extension AppVersion {
    static var placeholderData: AppVersion {
        return AppVersion(latestVersion: "-", currentVersion: "-")
    }
}
 
extension AppVersion {
    
    static var versionPubliser: AnyPublisher<AppVersion, Never> {
        // TODO: Change 아홉수 Bundle ID `let bundleID = "com.mashup.ahobsu.Ahobsu"`
        let bundleID = "com.yjh.Instavent"
        let bundleShortVersionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
        return URLSession.shared.dataTaskPublisher(for: URL(string: "http://itunes.apple.com/lookup?bundleId=\(bundleID)")!)
            .map { $0.data }
            .decode(type: ItunesLooup.Response.self, decoder: JSONDecoder())
            .compactMap { $0.results.first?.version }
            .replaceError(with: "0.0.0")
            .receive(on: DispatchQueue.main)
            .map { AppVersion(latestVersion: $0,
                              currentVersion: bundleShortVersionString) }
            .eraseToAnyPublisher()
    }
}

struct ItunesLooup {
    struct Response: Codable {
        var results: [Result]
    }
    struct Result: Codable {
        var version: String
    }
}
