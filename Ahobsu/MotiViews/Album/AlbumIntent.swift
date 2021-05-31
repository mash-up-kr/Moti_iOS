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
    @Published var currentYear: Int
    @Published var currentMonth: Int
    @Published var isLoading: Bool = false
    var isReloadNeeded: Bool = false

    private var months: [String] = []
    private var targetMonthIndex: Int = 0
    private var lastMonth: String?
    private var hasNextData: Bool = true

    private var cancels = Set<AnyCancellable>()

    init() {
        let calendar = Calendar.current
        let date = Date()
        self.currentYear = calendar.component(.year, from: date)
        self.currentMonth = calendar.component(.month, from: date)
        self.shelfXOffset = 0
        self.updateShelfOffset(for: date)

        NotificationCenter.default.publisher(for: .NSCalendarDayChanged).sink { [weak self] _ in
            DispatchQueue.main.async {
                withAnimation {
                    self?.updateShelfOffset(for: Date())
                }
            }
        }.store(in: &cancels)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        AhobsuProvider.getDays(completion: { rawDates in
            DispatchQueue.main.async {
                let dates: [Date] = rawDates?.data?.compactMap { formatter.date(from: $0) } ?? []
                self.months = Dictionary(grouping: dates) { Calendar.current.startOfMonth(for: $0) }.keys
                    .compactMap { formatter.string(from: $0) }
                    .sorted { $0 > $1 }
                self.lastMonth = self.months.last
                if self.months.isNotEmpty {
                    self.loadMore()
                }
            }
        }, error: { error in

        }, expireTokenAction: {

        }, filteredStatusCode: nil)
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
        guard let month = months[safe: targetMonthIndex] else { return }
        defer {
            targetMonthIndex += 1
        }
        self.isLoading = true
        AhobsuProvider.provider.requestPublisher(.getMonthAnswers(date: month))
            .retry(2)
            .map { $0.data }
            .decode(type: APIData<AnswerMonth>.self, decoder: JSONDecoder())
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
            } receiveValue: { [weak self] (answerMonth) in
                guard let self = self else { return }
                withAnimation {
                    let newAnswers = answerMonth.monthAnswer.flatMap { $0 }
                    if newAnswers.isEmpty {
                        self.loadMore()
                    } else {
                        let groupedAnswers = Dictionary(grouping: newAnswers) { $0?.no }
                        groupedAnswers.forEach {
                            self.answerMonth.append($0.value)
                        }
                        if newAnswers.contains(where: { $0?.date == self.lastMonth }) {
                            self.hasNextData = false
                        }
                    }
                }
            }
            .store(in: &cancels)
    }
//    func fetchAlbums() {
//        self.isLoading = true
//        AhobsuProvider.provider.requestPublisher(.getMonthAnswers(year: currentYear, month: currentMonth))
//            .retry(2)
//            .map { $0.data }
//            .decode(type: APIData<AnswerMonth>.self, decoder: JSONDecoder())
//            .tryCompactMap { $0.data }
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//            .sink { (completion) in
//                withAnimation {
//                    switch completion {
//                    case .failure:
//                        self.isReloadNeeded = true
//                    case .finished:
//                        self.isReloadNeeded = false
//                    }
//                    self.isLoading = false
//                }
//            } receiveValue: { (answerMonth) in
//                withAnimation {
//                    self.answerMonth = answerMonth
//                }
//            }
//            .store(in: &cancels)
//    }
}

// MARK: - Intent
extension AlbumItent {

    func onError() {
//        fetchAlbums()
    }
//
//    func onChangePage() {
////        fetchAlbums()
//    }
//    
//    func onAppear() {
////        fetchAlbums()
//    }

    func onRowAppear(answers: [Answer?]) {
        guard isLoading == false else { return }
        if answerMonth.last == answers {
            loadMore()
        }
    }
}
