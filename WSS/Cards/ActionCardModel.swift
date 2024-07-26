//
//  CardModel.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 18/07/2024.
//

import Foundation
import SwiftUI

struct WitcherAbilityCardModel: Hashable {
    let witcher: Witcher
    var isFront: Bool = true

    var imageName: String {
        isFront ? frontName : backName
    }

    let frontName: String
    let backName: String
}

struct ActionCardModel: Hashable, Codable, Identifiable {

    let isDrawn: Bool
    let imageName: String
    let id = UUID()
    let frontName: String
    let backName: String
    let cardType: ActionCardType
    let level: Int
    let number: Int

    init(
        isDrawn: Bool,
        frontName: String,
        backName: String,
        cardType: ActionCardType,
        level: Int,
        number: Int
    ) {
        self.isDrawn = isDrawn
        self.frontName = frontName
        self.backName = backName
        self.cardType = cardType
        self.level = level
        self.number = number
        self.imageName = isDrawn ? frontName : backName
    }

    // Implement Equatable
    static func == (lhs: ActionCardModel, rhs: ActionCardModel) -> Bool {
        return lhs.isDrawn == rhs.isDrawn &&
               lhs.frontName == rhs.frontName &&
               lhs.backName == rhs.backName &&
               lhs.cardType == rhs.cardType &&
               lhs.level == rhs.level &&
               lhs.number == rhs.number
    }

    // Implement Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(isDrawn)
        hasher.combine(frontName)
        hasher.combine(backName)
        hasher.combine(cardType)
        hasher.combine(level)
        hasher.combine(number)
    }

    // Implement Codable
    enum CodingKeys: String, CodingKey {
        case isDrawn
        case imageName
        case frontName
        case backName
        case cardType
        case level
        case number
    }

    func updating(isDrawn: Bool) -> Self {
        Self.init(
            isDrawn: isDrawn,
            frontName: frontName,
            backName: backName,
            cardType: cardType,
            level: level,
            number: number
        )
    }

    func updating(backName: String) -> Self {
        Self.init(
            isDrawn: isDrawn,
            frontName: frontName,
            backName: backName,
            cardType: cardType,
            level: level,
            number: number
        )
    }

    func updated() -> Self {
        Self.init(
            isDrawn: isDrawn,
            frontName: frontName,
            backName: backName,
            cardType: cardType,
            level: level,
            number: number
        )
    }
}



enum ActionCardType: Hashable, Equatable, Codable {
    case baseGeneral
    case baseAdvanced
    case skellige
    case legendaryHunt
}

enum ActionCardCategory: String, Hashable, Codable {
    case baseAction = "base"
    case legendaryHuntAction = "legendary-hunt"
    case skelligeAction = "skellige"
}

enum CardSubtype: String, Codable {
    case general
    case advanced
}

enum Witcher: String, Hashable, Codable {
    case bear
    case cat
    case ciri
    case griffin
    case manticore
    case viper
    case wolf
}
