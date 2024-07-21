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

final class ActionCardModel: ObservableObject, Hashable {

    @Published var isDrawn: Bool = false {
        didSet {
            print("Is drawn: \(isDrawn)")
            imageName = isDrawn ? frontName : backName
        }
    }

    @Published var imageName: String

    let frontName: String
    let backName: String
    let cardType: ActionCardType
    let level: Int
    // file number, not sure if will be useful
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
}

enum ActionCardType: Hashable, Equatable {
    case baseGeneral
    case baseAdvanced
    case skellige
    case legendaryHunt
}

enum ActionCardCategory: String, Hashable {
    case baseAction = "base"
    case legendaryHuntAction = "legendary-hunt"
    case skelligeAction = "skellige"
}

enum CardSubtype: String {
    case general
    case advanced
}

enum Witcher: String, Hashable {
    case bear
    case cat
    case ciri
    case griffin
    case manticore
    case viper
    case wolf
}
