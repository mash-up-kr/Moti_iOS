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
    case getWeekAnswers(mondayDate: String)
    case getAnswer(missionDate: String)

    /* Missions */
    case getMission
    case refreshMission

    /* SignIn */
    case signIn(snsId: Int)

    /* Token */
    case refreshToken

    /* Users */
    case signUp(name: String,
                birthday: String,
                email: String,
                gender: String,
                snsId: Int,
                snsType: String
    )
    case updateProfile(name: String,
                birthday: String,
                email: String,
                gender: String,
                snsId: Int,
                snsType: String
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
        case let .getWeekAnswers(mondayDate):
            return "/answers/week/\(mondayDate)"
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
        case .signUp:
            return "/users"
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
        case .signUp:
            return .post
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

        /* Token */
        case .refreshToken:
            /* Empty */
            break

        /* Users */
        case let .signUp(name,
                    birthday,
                    email,
                    gender,
                    snsId,
                    snsType):
            defaultParams["name"] = name
            defaultParams["birthday"] = birthday
            defaultParams["email"] = email
            defaultParams["gender"] = gender
            defaultParams["snsId"] = snsId
            defaultParams["snsType"] = snsType
        case let .updateProfile(name,
                    birthday,
                    email,
                    gender,
                    snsId,
                    snsType):
            defaultParams["name"] = name
            defaultParams["birthday"] = birthday
            defaultParams["email"] = email
            defaultParams["gender"] = gender
            defaultParams["snsId"] = snsId
            defaultParams["snsType"] = snsType
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
                    name: "file",
                    fileName: "answer.jpeg",
                    mimeType: "image/jpeg"))
                    formData.append(MultipartFormData(provider: .data(Data(from: content)),
                                                      name: "content"))
                    formData.append(MultipartFormData(provider: .data(Data(from: missionId)),
                                                      name: "missionId"))
                } else {
                    /* 사진 */
                    formData.append(MultipartFormData(provider: .data(imageData),
                    name: "file",
                    fileName: "answer.jpeg",
                    mimeType: "image/jpeg"))
                    formData.append(MultipartFormData(provider: .data(Data(from: missionId)),
                                                      name: "missionId"))
                }
            } else {
                /* 주관식 */
                if let content = contentOrNil {
                    formData.append(MultipartFormData(provider: .data(Data(from: content)),
                                                      name: "content"))
                    formData.append(MultipartFormData(provider: .data(Data(from: missionId)),
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
        case .signIn, .updateProfile, .signUp:
            return .requestParameters(parameters: params,
                                      encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        let authToken: String = TokenManager.sharedInstance.getToken()

        return ["Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": authToken]
    }

}
