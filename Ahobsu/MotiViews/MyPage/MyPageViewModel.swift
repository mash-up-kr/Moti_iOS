//
//  MyPageViewModel.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/02/01.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation
import Combine

final class MyPageViewModel: ObservableObject {
    
    static var shared: MyPageViewModel = MyPageViewModel()
    
    @Published var user: User = .placeholderData
    
    private var cancels = Set<AnyCancellable>()
    
    init() {
        userPublisher
            .assign(to: \.user, on: self)
            .store(in: &cancels)
    }
    
    var userPublisher: AnyPublisher<User, Never> {
        AhobsuProvider.provider.requestPublisher(.getProfile)
            .retry(2)
            .map { $0.data }
            .decode(type: APIData<User>.self, decoder: JSONDecoder())
            .tryCompactMap { $0.data }
            .replaceError(with: .placeholderData)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getNew() -> MyPageViewModel {
        let newModel = MyPageViewModel()
        MyPageViewModel.shared = newModel
        return newModel
    }
}
