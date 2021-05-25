//
//  DiaryIntent.swift
//  Ahobsu
//
//  Created by bran.new on 2021/03/15.
//  Copyright © 2021 ahobsu. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class DiaryIntent: ObservableObject {

    @Published var answers: [Answer] = []
    @Published var currentYear: Int
    @Published var currentMonth: Int
    @Published var isLoading: Bool = false
    @Published var date: Date = Date()
    @Published var specificPosition: Int?

    private var answerMonths: [AnswerDiary] = []
    private var canScrollToTop: Bool = false
    private var canScrollToBottom: Bool = true
    var isReloadNeeded: Bool = false

    private var subscriptions = Set<AnyCancellable>()

    init() {
        let calendar = Calendar.current
        let date = Date()
        self.currentYear = calendar.component(.year, from: date)
        self.currentMonth = calendar.component(.month, from: date)

        $date.sink { [weak self] newDate in
            guard let self = self else { return }
            // 이미 존재한다
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let newDateString = formatter.string(from: newDate)
            if let matchedAnswer = self.answers.first(where: { $0.date == newDateString }) {
                self.specificPosition = matchedAnswer.id
            }

            // 없으면 서버로 새로운 요청

        }.store(in: &subscriptions)
        fetchLatestDiary()
    }
}

// MARK: - Private Methods
private extension DiaryIntent {
    func fetchLatestDiary() {
        self.isLoading = true
        AhobsuProvider.provider.requestPublisher(.getDiary(direction: .orderedDescending, limit: 6, date: nil))
            .retry(2)
            .map { $0.data }
            .decode(type: APIData<AnswerDiary>.self, decoder: JSONDecoder())
            .tryCompactMap { $0.data }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { (completion) in
                withAnimation {
                    switch completion {
                    case .failure:
                        self.isReloadNeeded = true
                        self.isLoading = false
                    case .finished:
                        self.isReloadNeeded = false
                    }
                }
            } receiveValue: { (answerDiary) in
                withAnimation {
                    self.answers += answerDiary.answers
                    self.isLoading = false
                }
            }
            .store(in: &subscriptions)
    }

    func loadMoreDiary(direction: ComparisonResult, withDate date: String) {
        self.isLoading = true
        AhobsuProvider.provider.requestPublisher(.getDiary(direction: direction, limit: 6, date: date))
            .retry(2)
            .map { $0.data }
            .decode(type: APIData<AnswerDiary>.self, decoder: JSONDecoder())
            .tryCompactMap { $0.data }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink { (completion) in
                withAnimation {
                    switch completion {
                    case .failure:
                        self.isReloadNeeded = true
                        self.isLoading = false
                    case .finished:
                        self.isReloadNeeded = false
                    }
                }
            } receiveValue: { [weak self ] (answerDiary) in
                guard let self = self else { return }
                withAnimation {
                    switch direction {
                    case .orderedAscending:
                        self.canScrollToBottom = !answerDiary.answers.isEmpty
                        let newAnswers = Array(Set(self.answers + answerDiary.answers)).sorted { $0.date > $1.date }
                        let diff = newAnswers.difference(from: self.answers)
                        self.answers = self.answers.applying(diff) ?? self.answers
                    case .orderedDescending:
                        self.canScrollToTop = !answerDiary.answers.isEmpty
                        let newAnswers = Array(Set(answerDiary.answers + self.answers)).sorted { $0.date > $1.date }
                        let diff = newAnswers.difference(from: self.answers)
                        self.answers = self.answers.applying(diff) ?? self.answers
                    case .orderedSame:
                        break
                    }
                    self.isLoading = false
                }
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Intent
extension DiaryIntent {

    func onError() {
//        fetchLatestDiary()
    }

    func onAppear() {
        // TODO: 상황에 맞게 Refresh
    }

    func onRowAppear(answer: Answer) {
        guard isLoading == false else { return }
//        answerMonths.last?.monthAnswer.last == answerMonth
//        let answers: [Answer?] = answerMonths.reduce(Array<Answer?>()) {
//            let ff = $1.monthAnswer.flatMap { a in a }
//            return $0 + ff
//        }
        if let firstAnswer = answers.first, firstAnswer == answer {
            guard canScrollToTop else { return }
            loadMoreDiary(direction: .orderedDescending, withDate: firstAnswer.date)
        } else if let lastAnswer = answers.last, lastAnswer == answer {
            guard canScrollToBottom else { return }
            loadMoreDiary(direction: .orderedAscending, withDate: lastAnswer.date)
        } else {
            // Nothing
        }
    }

    func onChangeDate(_ date: Date) {
        self.date = date
//        refreshAlbums()
    }

    func shouldHaveMonthSeparator(with answer: Answer) -> Bool {
        guard let answerIndex = answers.firstIndex(of: answer), let previousAnswer = answers[safe: answerIndex - 1] else { return true }
        return answer.date.prefix(7) != previousAnswer.date.prefix(7)
    }
}

