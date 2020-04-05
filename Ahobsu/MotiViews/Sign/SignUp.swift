//
//  SignUp.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/01/12.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation
import Combine
import Moya

extension SignUp {
    enum Gender: String, CaseIterable {
        case male = "남"
        case female = "여"
    }
}

extension SignUp {
    struct Response: Codable {
        var status: Int
        var message: String
    }
}

class SignUp: ObservableObject {
    
    // Nickname
    var nickname: String = ""
    
    // Gende
    var gender: String = "미입력"
    
    // Birthdate
    var birthdate: String = "미입력"
    
    var email: String {
        return UserDefaults.standard.value(forKey: "com.ahobsu.AppleID") as? String ?? ""
    }
    
    private var cancels: Set<AnyCancellable> = []
    
    @Published var signUpSuccess: Bool = false
    
    func updateProfile() {
//        TokenManager.sharedInstance.registerGender(gender: gender.rawValue, completion: nil, error: nil)
        AhobsuProvider.updateProfile(user: User(id: -1,
                                                birthday: self.birthdate,
                                                email: email,
                                                name: nickname,
                                                gender: gender,
                                                refreshDate: nil,
                                                refreshToken: nil,
                                                mission: nil,
                                                snsId: "",
                                                snsType: ""),
                                     completion: { (response) in
                                        if let _ = response?.data {
                                            TokenManager.sharedInstance.registerAccessToken(token: TokenManager.sharedInstance.temporaryAccessToken ?? "",
                                                                                            completion: { _ in
                                                                                                TokenManager.sharedInstance.temporaryAccessToken = nil
                                            },
                                                                                            error: nil)
                                            TokenManager.sharedInstance.registerRefreshToken(token: TokenManager.sharedInstance.temporaryRefreshToken ?? "",
                                                                                             completion: { _ in
                                                                                                TokenManager.sharedInstance.temporaryRefreshToken = nil
                                            },
                                                                                             error: nil)
                                            self.signUpSuccess = true
                                        }
        }, error: { (error) in
            self.signUpSuccess = false
        }, expireTokenAction: {
            self.signUpSuccess = false
        }, filteredStatusCode: nil)
    }
}

// Helper
extension SignUp {
    private var dateFormatter: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFullDate
        return formatter
    }
}
