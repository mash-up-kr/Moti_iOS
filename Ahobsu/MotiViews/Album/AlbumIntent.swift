//
//  AlbumIntent.swift
//  Ahobsu
//
//  Created by bran.new on 2021/01/30.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import UIKit
import Combine
import SwiftUI

final class AlbumItent: ObservableObject {

    // For Shelf
    var shelfName: String = "imgAlbumShelf"
    var shelfHeight: CGFloat = 137
    @Published var shelfXOffset: CGFloat

    // For Albums
    @Published var answerMonth: [[Answer?]] = []
    @Published var isLoading: Bool = false
    var isReloadNeeded: Bool = false

    private var hasNextData: Bool = true

    private var cancels = Set<AnyCancellable>()

    init() {
        let date = Date()
        self.shelfXOffset = 0
        self.updateShelfOffset(for: date)

        NotificationCenter.default.publisher(for: .NSCalendarDayChanged).sink { [weak self] _ in
            DispatchQueue.main.async {
                withAnimation {
                    self?.updateShelfOffset(for: Date())
                }
            }
        }.store(in: &cancels)

        loadMore()
    }
}

// MARK: - Private Methods
private extension AlbumItent {

    func updateShelfOffset(for date: Date) {
        let day = Calendar.current.component(.day, from: date)
        let shelfImageName = "imgAlbumShelf"
        self.shelfName = shelfImageName
        let shelfHeight: CGFloat = 137
        self.shelfHeight = shelfHeight
        let uiImage = UIImage(named: shelfImageName)!
        // OffsetRange: 0...(uiImage.size.width - UIScreen.main.bounds.width)
        let adjustedWidth = uiImage.size.width / uiImage.size.height * shelfHeight
        let maxOffset = (adjustedWidth - UIScreen.main.bounds.width)
        let oneOffsetValue = maxOffset / 31
        let targetOffset = oneOffsetValue * CGFloat(day)
        self.shelfXOffset = -targetOffset
    }

    func loadMore() {
        guard hasNextData else { return }

        self.isLoading = true
        let lastAnswerID = answerMonth.last?.last??.id
        AhobsuProvider.provider.requestPublisher(.getAnswers(answerID: lastAnswerID))
            .retry(2)
            .map { $0.data }
            .decode(type: APIData<[[Answer]]>.self, decoder: JSONDecoder())
            .tryCompactMap { $0.data }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { [weak self] (completion) in
                guard let self = self else { return }
                withAnimation {
                    switch completion {
                    case .failure:
                        self.isReloadNeeded = true
                    case .finished:
                        self.isReloadNeeded = false
                    }
                    self.isLoading = false
                }
            } receiveValue: { [weak self] (answers) in
                guard let self = self else { return }
                withAnimation {
                    self.hasNextData = answers.isNotEmpty
                    answers.forEach {
                        self.answerMonth.append($0)
                    }
                }
            }
            .store(in: &cancels)
    }
}

// MARK: - Intent
extension AlbumItent {

    func onError() {
//        fetchAlbums()
    }

    func onRowAppear(answers: [Answer?]) {
        guard isLoading == false else { return }
        if answerMonth.last == answers {
            loadMore()
        }
    }
}
