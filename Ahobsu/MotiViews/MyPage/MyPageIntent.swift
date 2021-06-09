//
//  MyPageIntent.swift
//  Ahobsu
//
//  Created by bran.new on 2021/01/29.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import UIKit
import Combine
import Kingfisher

final class MyPageIntent: ObservableObject {
    static let shared = MyPageIntent() // 계속 유저가 초기화되는 버그때문에 임시로 shared 사용
    
    @Published var user: User = .placeholderData
    @Published var image: UIImage? = nil
    private var cancels = Set<AnyCancellable>()
    
    private init() { }
}

// MARK: Intent
extension MyPageIntent {
    func onAppear() {
        getProfile()
    }
    
    func updateImage(_ image: UIImage?) {
        updateProfileImage(image: image)
    }
}


extension MyPageIntent {
    private func getProfile() {
        AhobsuProvider.provider.requestPublisher(.getProfile)
            .map { $0.data }
            .decode(type: APIData<User>.self, decoder: JSONDecoder())
            .tryCompactMap { $0.data }
            .replaceError(with: .placeholderData)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .scan(user, { [weak self] oldValue, newValue in
                guard let self = self else { return newValue }
                if let profileUrl = newValue.profileUrl, oldValue.profileUrl != newValue.profileUrl {
                    guard let url = URL(string: profileUrl) else { return newValue }
                    ImageDownloader.default.downloadImage(with: url, options: [.targetCache(.default)]) { result in
                        switch result {
                        case let .success(value):
                            self.image = value.image
                        case let .failure(error):
                            print(error)
                        }
                    }
                }
                
                return newValue
            })
            .assign(to: \.user, on: self)
            .store(in: &cancels)
    }
    
    private func updateProfileImage(image: UIImage?) {
        AhobsuProvider.provider.requestPublisher(.updateProfileImage(image: image))
            .map { $0.data }
            .decode(type: APIData<User>.self, decoder: JSONDecoder())
            .tryCompactMap { $0.data }
            .replaceError(with: .placeholderData)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .scan(user, { [weak self] oldValue, newValue in
                guard let self = self else { return newValue }
                if let profileUrl = newValue.profileUrl, oldValue.profileUrl != newValue.profileUrl {
                    guard let url = URL(string: profileUrl) else { return newValue }
                    ImageDownloader.default.downloadImage(with: url, options: nil) { result in
                        switch result {
                        case let .success(value):
                            self.image = value.image
                        case let .failure(error):
                            print(error)
                        }
                    }
                }
                
                return newValue
            })
            .assign(to: \.user, on: self)
            .store(in: &cancels)
    }
    
}
