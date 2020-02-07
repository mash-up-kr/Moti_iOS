//
//  AhobsuAPI.swift
//  Ahobsu
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Foundation
import UIKit
import Moya

enum AhobsuAPI {
    /* Answers */
    case registerAnswer(missionId: Int, contentOrNil: String?, imageOrNil: UIImage?)
    case updateAnswer(answerId: Int, contentOrNil: String?, imageOrNil: UIImage?)
    case getWeekAnswers
    case getMonthAnswers(year: Int, month: Int)
    case getAnswer(missionDate: String)
    
    /* Missions */
    case getMission
    case refreshMission
    
    /* SignIn */
    case signIn(snsId: String, auth: String)
    
    /* Token */
    case refreshToken
    
    /* Users */
    case updateProfile(name: String,
        birthday: String,
        email: String,
        gender: String
    )
    case deleteProfile
    case getProfile
}

extension AhobsuAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: AHOBSUAPIURL)
            else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
            /* Answers */
        case .registerAnswer:
            return "/answers"
        case let .updateAnswer(answerId):
            return "/answers/\(answerId)"
        case .getWeekAnswers:
            return "/answers/week"
        case let .getMonthAnswers(year, month):
            return "/answers/month/\(year)-\(month)-01"
        case let .getAnswer(missionDate):
            return "/answers/\(missionDate)"
            
            /* Missions */
        case .getMission:
            return "/missions"
        case .refreshMission:
            return "/missions/refresh"
            
            /* SignIn */
        case .signIn:
            return "/signin"
            
            /* Token */
        case .refreshToken:
            return "/signin/refresh"
            
            /* Users */
        case .updateProfile:
            return "/users"
        case .deleteProfile:
            return "/users"
        case .getProfile:
            return "/users/my"
        }
    }
    
    var method: Moya.Method {
        switch self {
            /* Answers */
        case .registerAnswer:
            return .post
        case .updateAnswer:
            return .put
        case .getWeekAnswers:
            return .get
        case .getMonthAnswers:
            return .get
        case .getAnswer:
            return .get
            
            /* Missions */
        case .getMission:
            return .get
        case .refreshMission:
            return .get
            
            /* SignIn */
        case .signIn:
            return .post
            
            /* Token */
        case .refreshToken:
            return .post
            
            /* Users */
        case .updateProfile:
            return .put
        case .deleteProfile:
            return .delete
        case .getProfile:
            return .get
        }
    }
    
    var sampleData: Data {
        return .init()
    }
    
    var params: [String: Any] {
        var defaultParams: [String: Any] = [:]
        
        switch self {
            /* Answers */
        case let .registerAnswer(missionId, contentOrNil, imageOrNil):
            defaultParams["missionId"] = missionId
            defaultParams["content"] = contentOrNil
            defaultParams["file"] = imageOrNil
        case let .updateAnswer(answerId, contentOrNil, imageOrNil):
            defaultParams["answerId"] = answerId
            defaultParams["content"] = contentOrNil
            defaultParams["file"] = imageOrNil
        case .getWeekAnswers:
            /* Empty */
            break
        case .getMonthAnswers:
            /* Empty */
            break
        case .getAnswer:
            /* Empty */
            break
            
            /* Missions */
        case .getMission:
            /* Empty */
            break
        case .refreshMission:
            /* Empty */
            break
            
            /* SignIn */
        case let .signIn(snsId):
            /* Empty */
            defaultParams["snsId"] = snsId
            defaultParams["snsType"] = "apple"
            /* Token */
        case .refreshToken:
            /* Empty */
            break
            
            /* Users */
        case let .updateProfile(name,
                                birthday,
                                email,
                                gender):
            defaultParams["name"] = name
            defaultParams["birthday"] = birthday
            defaultParams["email"] = email
            defaultParams["gender"] = gender
        case .deleteProfile:
            /* Empty */
            break
        case .getProfile:
            /* Empty */
            break
        }
        
        return defaultParams
    }
    
    var task: Task {
        switch self {
        case let .registerAnswer(missionId, contentOrNil, imageOrNil):
            
            var formData: [MultipartFormData] = []
            
            if let image = imageOrNil {
                guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                    fatalError("Cannot convert to JPEG")
                }
                
                if let content = contentOrNil {
                    /* 주관식 + 사진 (혼합형) */
                    formData.append(MultipartFormData(provider: .data(imageData),
                                                      name: "answer",
                                                      fileName: "answer.jpeg",
                                                      mimeType: "image/jpeg"))
                    
                    formData.append(MultipartFormData(provider: .data(content.data(using: .utf8)!),
                                                      name: "content"))
                    formData.append(MultipartFormData(provider: .data("\(missionId)".data(using: .utf8)!),
                                                      name: "missionId"))
                } else {
                    /* 사진 */
                    formData.append(MultipartFormData(provider: .data(imageData),
                                                      name: "file",
                                                      fileName: "answer.jpeg",
                                                      mimeType: "image/jpeg"))
                    formData.append(MultipartFormData(provider: .data("\(missionId)".data(using: .utf8)!),
                                                      name: "missionId"))
                }
            } else {
                /* 주관식 */
                if let content = contentOrNil {
                    formData.append(MultipartFormData(provider: .data(content.data(using: .utf8)!),
                                                      name: "content"))
                    formData.append(MultipartFormData(provider: .data("\(missionId)".data(using: .utf8)!),
                                                      name: "missionId"))
                } else {
                    fatalError("Both Content and Image must not be nil")
                }
            }
            
            return .uploadMultipart(formData)
        case let .updateAnswer(answerId, contentOrNil, imageOrNil):
            
            var formData: [MultipartFormData] = []
            formData.append(MultipartFormData(provider: .data(Data(from: answerId)),
                                              name: "answerId"))
            
            if let image = imageOrNil {
                guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                    fatalError("Cannot convert to JPEG")
                }
                
                if let content = contentOrNil {
                    /* 주관식 + 사진 (혼합형) */
                    formData.append(MultipartFormData(provider: .data(imageData),
                                                      name: "file",
                                                      fileName: "answer.jpeg",
                                                      mimeType: "image/jpeg"))
                    formData.append(MultipartFormData(provider: .data(Data(from: content)),
                                                      name: "content"))
                } else {
                    /* 사진 */
                    formData.append(MultipartFormData(provider: .data(imageData),
                                                      name: "file",
                                                      fileName: "answer.jpeg",
                                                      mimeType: "image/jpeg"))
                }
            } else {
                /* 주관식 */
                if let content = contentOrNil {
                    formData.append(MultipartFormData(provider: .data(Data(from: content)),
                                                      name: "content"))
                } else {
                    fatalError("Both Content and Image must not be nil")
                }
            }
            
            return .uploadMultipart(formData)
        case .updateProfile:
            return .requestParameters(parameters: params,
                                      encoding: JSONEncoding.default)
        case let .signIn(snsId, _):
            let params = [
                "snsId": snsId,
                "snsType": "apple"
            ]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        var authToken: String = TokenManager.sharedInstance.getToken()
        
        switch self {
        case let .signIn(_, auth):
            authToken = auth
        default:
            break
        }
        
        return ["Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": authToken]
    }
    
}
