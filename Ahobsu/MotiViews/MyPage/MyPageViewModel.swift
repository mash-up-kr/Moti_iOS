//
//  MyPageViewModel.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/02/01.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation
import Combine

class MyPageViewModel: ObservableObject {
    
    @Published var user: User = .placeholderData
    
    private var cancels: Set<AnyCancellable> = []
    
    func getUser() {
        AhobsuProvider.provider.requestPublisher(.getProfile)
            .retry(2)
            .map { $0.data }
            .decode(type: StatusDataWrapper<User>.self, decoder: JSONDecoder())
            .tryCompactMap { $0.model }
            .replaceError(with: .placeholderData)
            .receive(on: DispatchQueue.main)
            .assign(to: \.user, on: self)
            .store(in: &cancels)
    }
}
