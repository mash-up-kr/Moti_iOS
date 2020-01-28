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
    @Published var birthdate: Date = Date(timeIntervalSince1970: 0)

    @Published var inputComplete: Bool = false

    private var cancels: Set<AnyCancellable> = []

    var signUpSuccess: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(validatedNickname, $gender, $birthdate, $inputComplete)
            .tryMap { (nickName, gender, _, signUpComplete) -> AhobsuAPI in
                guard
                    let nickName = nickName,
                    let gender = gender,
                    signUpComplete == true
                else {
                    throw CocoaError(.propertyListReadCorrupt)
                }
                return AhobsuAPI.updateProfile(name: nickName,
                                               birthday: self.dateFormatter.string(from: self.birthdate),
                                               email: "",
                                               gender: gender.rawValue,
                                               snsId: 1,
                                               snsType: "apple") }
            .flatMap { (signUpAPI) -> Future<Bool, Error> in
                Future<Bool, Error> { (promise) in
                    AhobsuProvider.provider.requestPublisher(signUpAPI)
                        .map { $0.data }
                        .decode(type: SignUp.Response.self, decoder: JSONDecoder())
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { (_) in },
                              receiveValue: { (response) in
                                promise(.success(response.status == 200)) })
                        .store(in: &self.cancels)
                }}
            .replaceError(with: false)
            .eraseToAnyPublisher()
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
