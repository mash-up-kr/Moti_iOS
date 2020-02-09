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
    @Published var nickname: String = ""
    var validatedNickname: AnyPublisher<String?, Never> {
        return $nickname.map {
            guard !$0.isEmpty && $0.count <= 8 else { return nil }
            return $0
        }.eraseToAnyPublisher()
    }
    
    // Gende
    @Published var gender: Gender?
    
    // Birthdate
    @Published var birthdate: Date = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFullDate
        return formatter.date(from: "2000-02-14") ?? Date()
    }()
    
    var email: String {
        return UserDefaults.standard.value(forKey: "com.ahobsu.AppleID") as? String ?? ""
    }
    
    private var cancels: Set<AnyCancellable> = []
    
    @Published var signUpSuccess: Bool = false
    
    func updateProfile() {
        guard let gender = gender else { return }
        AhobsuProvider.updateProfile(user: User(id: -1,
                                                birthday: dateFormatter.string(from: self.birthdate),
                                                email: email,
                                                name: nickname,
                                                gender: gender.rawValue,
                                                refreshDate: nil,
                                                refreshToken: nil,
                                                mission: nil,
                                                snsId: "",
                                                snsType: ""),
                                     completion: { (response) in
                                        if let _ = response?.data {
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
