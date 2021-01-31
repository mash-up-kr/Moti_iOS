//
//  MyPageIntent.swift
//  Ahobsu
//
//  Created by bran.new on 2021/01/29.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import Foundation
import Combine

final class MyPageIntent: ObservableObject {

    @Published var user: User = .placeholderData
    private var cancels = Set<AnyCancellable>()

}

// MARK: Intent
extension MyPageIntent {
    func onAppear() {
        AhobsuProvider.provider.requestPublisher(.getProfile)
            .retry(2)
            .map { $0.data }
            .decode(type: APIData<User>.self, decoder: JSONDecoder())
            .tryCompactMap { $0.data }
            .replaceError(with: .placeholderData)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .assign(to: \.user, on: self)
            .store(in: &cancels)
    }
}
