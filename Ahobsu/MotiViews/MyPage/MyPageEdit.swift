//
//  MyPageEdit.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/01/27.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation
import Combine

extension MyPageEdit {
    struct DeleteResponse: Codable {
        var status: Int
        var message: String
    }
}

final class MyPageEdit: ObservableObject {
    
    private var cancels: Set<AnyCancellable> = []
    @Published var deletingUserSucccess: Bool = false
    
    func deleteUser() {
        AhobsuProvider.provider.requestPublisher(.deleteProfile)
            .retry(2)
            .map { $0.data }
            .decode(type: DeleteResponse.self, decoder: JSONDecoder())
            .allSatisfy { $0.status == 200 }
            .replaceError(with: false)
            .receive(on: DispatchQueue.main)
            .assign(to: \.deletingUserSucccess, on: self)
            .store(in: &cancels)
    }
}
