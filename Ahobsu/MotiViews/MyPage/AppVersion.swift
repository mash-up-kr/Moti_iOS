//
//  AppVersion.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/01/29.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation
import Combine

class AppVersion: ObservableObject {

    @Published var latestVersion: String = "0.0.0"
    @Published var currentVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"

    private var cancels = Set<AnyCancellable>()

    init() {
        fetchVersion()
    }

    func fetchVersion() {
        // TODO: Change 아홉수 Bundle ID `let bundleID = "com.mashup.ahobsu.Ahobsu"`
        let bundleID = "com.yjh.Instavent"
        URLSession.shared.dataTaskPublisher(for: URL(string: "http://itunes.apple.com/lookup?bundleId=\(bundleID)")!)
            .map { $0.data }
            .decode(type: ItunesLooup.Response.self, decoder: JSONDecoder())
            .compactMap { $0.results.first?.version }
            .replaceError(with: "0.0.0")
            .assign(to: \.latestVersion, on: self)
            .store(in: &cancels)
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
