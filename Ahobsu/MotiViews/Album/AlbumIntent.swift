//
//  AlbumIntent.swift
//  Ahobsu
//
//  Created by bran.new on 2021/01/30.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class AlbumItent: ObservableObject {
    @Published var answerMonth: AnswerMonth?
    @Published var currentYear: Int
    @Published var currentMonth: Int
    @Published var isLoading: Bool = false
    var isReloadNeeded: Bool = false

    private var cancels = Set<AnyCancellable>()

    init() {
        let calendar = Calendar.current
        let date = Date()
        self.currentYear = calendar.component(.year, from: date)
        self.currentMonth = calendar.component(.month, from: date)
    }
}

// MARK: - Private Methods
private extension AlbumItent {
    func fetchAlbums() {
        self.isLoading = true
        AhobsuProvider.provider.requestPublisher(.getMonthAnswers(year: currentYear, month: currentMonth))
            .retry(2)
            .map { $0.data }
            .decode(type: APIData<AnswerMonth>.self, decoder: JSONDecoder())
            .tryCompactMap { $0.data }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { (completion) in
                withAnimation {
                    switch completion {
                    case .failure:
                        self.isReloadNeeded = true
                    case .finished:
                        self.isReloadNeeded = false
                    }
                    self.isLoading = false
                }
            } receiveValue: { (answerMonth) in
                withAnimation {
                    self.answerMonth = answerMonth
                }
            }
            .store(in: &cancels)
    }
}

// MARK: - Intent
extension AlbumItent {

    func onError() {
        fetchAlbums()
    }

    func onChangePage() {
        fetchAlbums()
    }
    
    func onAppear() {
        fetchAlbums()
    }
}
