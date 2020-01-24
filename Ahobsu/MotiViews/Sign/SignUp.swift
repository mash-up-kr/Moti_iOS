//
//  SignUp.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/01/12.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation
import Combine

extension SignUp {

    enum Gender: String, CaseIterable {
        case male
        case female
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
    @Published var birthdate: Date = Date(timeIntervalSince1970: 0)
}
