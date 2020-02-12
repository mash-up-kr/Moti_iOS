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
    var genderToValid: String
}

final class TokenManager {
    
    static let sharedInstance = TokenManager()
    
    private var tokens: Tokens = Tokens(accessToken: "", refreshToken: "", genderToValid: "-")
    
    private var neededTokenType: TokenType = .access
    
    private init() {
        loadTokensFormKeyChain()
        loadGenderFormKeyChain()
    }
    
    func resetTokensFromKeyChain(completion: ((OSStatus) -> Void)?,
                                 error: ((OSStatus) -> Void)?) {
        let accessTokenStatus: OSStatus = KeyChain.delete(key: "ahobsu_accesstoken")
        let refreshTokenStatus = KeyChain.delete(key: "ahobsu_refreshtoken")
        let genderStatus = KeyChain.delete(key: "ahobsu_genderStatus")
        if accessTokenStatus == errSecSuccess && refreshTokenStatus == errSecSuccess {
            completion?(accessTokenStatus)
        } else {
            error?((accessTokenStatus != errSecSuccess) ? accessTokenStatus : refreshTokenStatus)
        }
    }
    
    func loadTokensFormKeyChain() {
        if let receivedData = KeyChain.load(key: "ahobsu_accesstoken") {
            let result = String(data: receivedData, encoding: .utf8) ?? ""
            tokens.accessToken = result
        }
        
        if let receivedData = KeyChain.load(key: "ahobsu_refreshtoken") {
            let result = String(data: receivedData, encoding: .utf8) ?? ""
            tokens.refreshToken = result
        }
    }
    
    func registerAccessToken(token: String,
                             completion: ((OSStatus) -> Void)?,
                             error: ((OSStatus) -> Void)?) {
        let tokenData: Data = token.data(using: .utf8)!
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
        let tokenData: Data = token.data(using: .utf8)!
        let status: OSStatus = KeyChain.save(key: "ahobsu_refreshtoken", data: tokenData)
        
        loadTokensFormKeyChain()
        
        if status == errSecSuccess {
            completion?(status)
        } else {
            error?(status)
        }
    }
    
    func loadGenderFormKeyChain() {
         if let receivedData = KeyChain.load(key: "ahobsu_genderStatus") {
             let result = String(data: receivedData, encoding: .utf8) ?? ""
             tokens.genderToValid = result
         }
     }
    
    func registerGender(gender: String?,
                        completion: ((OSStatus) -> Void)?,
                        error: ((OSStatus) -> Void)?) {
        let genderData: Data = (gender ?? "-").data(using: .utf8)!
        let status: OSStatus = KeyChain.save(key: "ahobsu_genderStatus", data: genderData)
        
        loadTokensFormKeyChain()
        
        if status == errSecSuccess {
            completion?(status)
        } else {
            error?(status)
        }
    }
    
    
    func getGender() -> String {
        return tokens.genderToValid
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
