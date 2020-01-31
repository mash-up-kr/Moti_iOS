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
    case getAnswersWeek
    
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
        case .getAnswersWeek:
            return "/answers/week"

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
        case .getAnswer:
            return .get
        case .getAnswersWeek:
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
        case .getAnswer:
            /* Empty */
            break
        case .getAnswersWeek:
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
                    gender,
                    snsId,
                    snsType):
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
                if let content = contentOrNil,
                    let contentData = content.data(using: .utf8),
                    let missionData = "\(missionId)".data(using: .utf8) {
                    formData.append(MultipartFormData(provider: .data(contentData),
                                                      name: "content"))
                    formData.append(MultipartFormData(provider: .data(missionData),
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
        var authToken: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJiaXJ0aGRheSI6IjE5OTctMDEtMTYiLCJlbWFpbCI6Inl1Y2hvY29waWVAZ21haWwuY29tIiwibmFtZSI6IuycoOyglSIsImdlbmRlciI6IuyXrCIsInJlZnJlc2hEYXRlIjoiMjAyMC0wMS0yOCIsInJlZnJlc2hUb2tlbiI6bnVsbCwibWlzc2lvbiI6IntcImRhdGVcIjpcIjIwMjAtMDEtMjhcIixcIm1pc3Npb25zXCI6W3tcImlkXCI6MSxcInRpdGxlXCI6XCLrrLjsoJxcIixcImlzQ29udGVudFwiOjEsXCJpc0ltYWdlXCI6MCxcImN5Y2xlXCI6MSxcImNyZWF0ZWRBdFwiOlwiMjAyMC0wMS0xMiAyMDo1NDozNFwiLFwidXBkYXRlZEF0XCI6XCIyMDIwLTAxLTEyIDIwOjU0OjM0XCJ9LHtcImlkXCI6NjcsXCJ0aXRsZVwiOlwi7JWI64WVMlwiLFwiaXNDb250ZW50XCI6MSxcImlzSW1hZ2VcIjowLFwiY3ljbGVcIjoxLFwiY3JlYXRlZEF0XCI6XCIyMDIwLTAxLTI3IDIyOjQ0OjU4XCIsXCJ1cGRhdGVkQXRcIjpcIjIwMjAtMDEtMjcgMjI6NDQ6NThcIn0se1wiaWRcIjo2OCxcInRpdGxlXCI6XCLslYjrhZUyXCIsXCJpc0NvbnRlbnRcIjoxLFwiaXNJbWFnZVwiOjAsXCJjeWNsZVwiOjEsXCJjcmVhdGVkQXRcIjpcIjIwMjAtMDEtMjcgMjI6NDQ6NTlcIixcInVwZGF0ZWRBdFwiOlwiMjAyMC0wMS0yNyAyMjo0NDo1OVwifV19Iiwic25zSWQiOiIxIiwic25zVHlwZSI6ImFwcGxlIiwiY3JlYXRlZEF0IjoiMjAyMC0wMS0yOCAwMDo0OTo0MSIsInVwZGF0ZWRBdCI6IjIwMjAtMDEtMjggMDk6MTI6NDcifSwiaWF0IjoxNTgwMjY3NzEwLCJleHAiOjE1ODA4NzI1MTB9.or-4T0F5uKL_JCJGERk9p5gooUzmTGfsrGoCZqKNa6M"
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
