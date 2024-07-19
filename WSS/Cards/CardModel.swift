//
//  CardModel.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 18/07/2024.
//

import Foundation
import SwiftUI

struct CardModel: Hashable {

    var isFront: Bool = true

    var imageName: String {
        isFront ? frontName : backName
    }

    let frontName: String
    let backName: String
    let cardType: CardType
}

enum CardType: Hashable {
    case baseGeneral(level: Int, number: Int)
    case baseAdvanced(level: Int, number: Int)
    case skellige(level: Int, number: Int)
    case legendaryHunt(level: Int, number: Int)
    case witcherAbility(witcher: Witcher)
}

extension CardType {
    enum SimpleCardType {
        case baseGeneral
        case baseAdvanced
        case skellige
        case legendaryHunt
        case witcherAbility
    }
    var caseWithoutAssociatedValues: SimpleCardType {
        switch self {
        case .baseGeneral:
            return .baseGeneral
        case .baseAdvanced:
            return .baseAdvanced
        case .skellige:
            return .skellige
        case .legendaryHunt:
            return .legendaryHunt
        case .witcherAbility:
            return .witcherAbility
        }
    }
}

enum CardCategory: String, Hashable {
    case baseAction = "base"
    case witcher
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
