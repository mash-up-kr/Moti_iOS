//
//  AhobsuProvider.swift
//  Ahobsu
//
//  Created by admin on 2019/11/23.
//  Copyright © 2019 ahobsu. All rights reserved.
//

import Moya

class AhobsuProvider {
    static let provider = AhobsuNetworking()

    /* Answers */

    class func registerAnswer(missionId: Int,
                              contentOrNil: String?,
                              imageOrNil: UIImage?,
                              completion: @escaping ((Response) -> Void),
                              error: @escaping ((MoyaError) -> Void)) {
        provider.request(.registerAnswer(missionId: missionId,
                                         contentOrNil: contentOrNil,
                                         imageOrNil: imageOrNil),
                         completionHandler: completion,
                         errorHandler: error)
    }

    class func updateAnswer(answerId: Int,
                            contentOrNil: String?,
                            imageOrNil: UIImage?,
                            completion: @escaping ((Response) -> Void),
                            error: @escaping ((MoyaError) -> Void)) {
        provider.request(.updateAnswer(answerId: answerId,
                                       contentOrNil: contentOrNil,
                                       imageOrNil: imageOrNil),
                        completionHandler: completion,
                        errorHandler: error)
    }

    class func getWeekAnswer(mondayDate: String,
                             completion: @escaping ((Response) -> Void),
                             error: @escaping ((MoyaError) -> Void)) {
        provider.request(.getWeekAnswers(mondayDate: mondayDate),
                         completionHandler: completion,
                         errorHandler: error)
    }

    class func getAnswer(missionDate: String,
                         completion: @escaping ((Response) -> Void),
                         error: @escaping ((MoyaError) -> Void)) {
        provider.request(.getAnswer(missionDate: missionDate),
                         completionHandler: completion,
                         errorHandler: error)
    }

    /* Missions */

    class func getMission(completion: @escaping ((Response) -> Void),
                          error: @escaping ((MoyaError) -> Void)) {
        provider.request(.getMission,
                         completionHandler: completion,
                         errorHandler: error)
    }

    class func refreshMission(completion: @escaping ((Response) -> Void),
                              error: @escaping ((MoyaError) -> Void)) {
        provider.request(.refreshMission,
                        completionHandler: completion,
                        errorHandler: error)
    }

    /* SignIn */

    class func signIn(snsId: String,
                      auth: String,
                      completion: @escaping ((Response) -> Void),
                      error: @escaping ((MoyaError) -> Void)) {
        provider.request(.signIn(snsId: snsId, auth: auth),
                         completionHandler: completion,
                         errorHandler: error)
    }

    /* Token */

    class func refreshToken(completion: @escaping ((Response) -> Void),
                            error: @escaping ((MoyaError) -> Void)) {
        provider.request(.refreshToken,
                        completionHandler: completion,
                        errorHandler: error)
    }

    /* Users */

    class func updateProfile(user: User,
                             completion: @escaping ((Response) -> Void),
                             error: @escaping ((MoyaError) -> Void)) {
        provider.request(.updateProfile(name: user.name,
                                        birthday: user.birthday,
                                        email: user.email,
                                        gender: user.gender,
                                        snsId: user.snsId,
                                        snsType: user.snsType),
                        completionHandler: completion,
                        errorHandler: error)
    }

    class func deleteProfile(completion: @escaping ((Response) -> Void),
                             error: @escaping ((MoyaError) -> Void)) {
        provider.request(.deleteProfile,
                         completionHandler: completion,
                         errorHandler: error)
    }

    class func getProfile(completion: @escaping ((Response) -> Void),
                          error: @escaping ((MoyaError) -> Void)) {
        provider.request(.getProfile,
                         completionHandler: completion,
                         errorHandler: error)
    }
}
