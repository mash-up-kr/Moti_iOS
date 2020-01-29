//
//  TokenManager.swift
//  Ahobsu
//
//  Created by admin on 2020/01/12.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation
import Security

enum TokenType {
    case refresh
    case access
}

struct Tokens {
    var accessToken: String
    var refreshToken: String
}

final class TokenManager {

    static let sharedInstance = TokenManager()

    private var tokens: Tokens = Tokens(accessToken: "", refreshToken: "")

    private var neededTokenType: TokenType = .access

    private init() {
        loadTokensFormKeyChain()
    }

    func loadTokensFormKeyChain() {
        if let receivedData = KeyChain.load(key: "ahobsu_accesstoken") {
            let result = receivedData.to(type: String.self)
            tokens.accessToken = result
        }

        if let receivedData = KeyChain.load(key: "ahobsu_refreshtoken") {
            let result = receivedData.to(type: String.self)
            tokens.refreshToken = result
        }
    }

    func registerAccessToken(token: String,
                             completion: ((OSStatus) -> Void)?,
                             error: ((OSStatus) -> Void)?) {
        let tokenData: Data = Data(from: token)
        let status: OSStatus = KeyChain.save(key: "ahobsu_accesstoken", data: tokenData)

        loadTokensFormKeyChain()

        if status == errSecSuccess {
            completion?(status)
        } else {
            error?(status)
        }
    }

    func registerRefreshToken(token: String,
                              completion: ((OSStatus) -> Void)?,
                              error: ((OSStatus) -> Void)?) {
        let tokenData: Data = Data(from: token)
        let status: OSStatus = KeyChain.save(key: "ahobsu_refreshtoken", data: tokenData)

        loadTokensFormKeyChain()

        if status == errSecSuccess {
            completion?(status)
        } else {
            error?(status)
        }
    }

    func getAccessToken() -> String {
        return tokens.accessToken
    }

    func getRefreshToken() -> String {
        return tokens.refreshToken
    }

    func setNeededTokenType(tokenType: TokenType) {
        neededTokenType = tokenType
    }

    func getToken() -> String {
        switch neededTokenType {
        case .access:
            return getAccessToken()
        case .refresh:
            return getRefreshToken()
        }
    }

    func getToken(tokenType: TokenType) -> String {
        switch tokenType {
        case .access:
            return getAccessToken()
        case .refresh:
            return getRefreshToken()
        }
    }

}
