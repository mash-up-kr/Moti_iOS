//
//  Card.swift
//  Ahobsu
//
//  Created by 이호찬 on 2020/01/29.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import Foundation

struct SingleCardData: Codable {
    let status: Int
    let message: String
    let data: Card
}

struct CardData: Codable {
    let status: Int
    let message: String
    let data: [Card?]
}

struct Card: Codable {
    let id: Int
    let userId: Int
    let missionId: Int
    let imageUrl: String?
    let cardUrl: String?
    let content: String
    let date: String
}
