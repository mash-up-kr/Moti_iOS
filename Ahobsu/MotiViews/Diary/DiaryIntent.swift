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
    @Published var userSelectedDate: Date = Date()
    @Published var specificPosition: Int?

    private var answerMonths: [AnswerDiary] = []
    private var canScrollToTop: Bool = false
    private var canScrollToBottom: Bool = true
    var isReloadNeeded: Bool = false

    private let dateFormatter: DateFormatter
    private var subscriptions = Set<AnyCancellable>()

    init() {
        let calendar = Calendar.current
        let date = Date()
        self.currentYear = calendar.component(.year, from: date)
        self.currentMonth = calendar.component(.month, from: date)
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "yyyy-MM-dd"

        $userSelectedDate
            .dropFirst()
            .sink { [weak self] newDate in
                guard let self = self else { return }

                let newDateString = self.dateFormatter.string(from: newDate)
                if let matchedAnswer = self.answers.first(where: { $0.date == newDateString }) {
                    // 이미 존재한다
                    self.specificPosition = matchedAnswer.id
                } else {
                    // 없으면 서버로 새로운 요청
                    let nearDateString = self.dateFormatter.string(from: newDate.addingTimeInterval(60*60*24))
                    self.loadDiaryForSelectedDate(direction: .orderedAscending, withDate: nearDateString)
                }
            }.store(in: &subscriptions)
        fetchLatestDiary()
    }
}

// MARK: - Private Methods
private extension DiaryIntent {
    private func fetchLatestDiary() {
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
                    self.answers = answerDiary.answers
                    self.isLoading = false
                }
            }
            .store(in: &subscriptions)
    }

    private func loadMoreDiary(direction: ComparisonResult, withDate date: String) {
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

    private func loadDiaryForSelectedDate(direction: ComparisonResult, withDate date: String) {
        self.isLoading = true

        // 초기화 진행
        self.answers = []
        canScrollToTop = true
        canScrollToBottom = true

        // 데이터 로드
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

    func onTopInsetAppear() {
        guard isLoading == false else { return }
        guard canScrollToTop else { return }
        if let firstAnswer = answers.first {
            loadMoreDiary(direction: .orderedDescending, withDate: firstAnswer.date)
        }
    }

    /// 마지막 셀이 보일 때 추가 로드를 위한 메소드
    /// - Parameter answer: 마지막 셀을 표현한 Answer 데이터
    func onRowAppear(answer: Answer) {
        guard isLoading == false else { return }
         if let lastAnswer = answers.last, lastAnswer == answer {
            guard canScrollToBottom else { return }
            loadMoreDiary(direction: .orderedAscending, withDate: lastAnswer.date)
        }
    }

    func monthSeparatorTitle(of answer: Answer) -> String? {
        guard let answerIndex = answers.firstIndex(of: answer),
              let answerDate = answer.dateForDate else { return nil }

        if answerIndex == 0 {
            return String(dateFormatter.string(from: answerDate).prefix(7))
        } else if let previousAnswer = answers[safe: answerIndex - 1],
                  answer.date.prefix(7) != previousAnswer.date.prefix(7) {
            return String(dateFormatter.string(from: answerDate).prefix(7))
        } else {
            return nil
        }
    }
}

