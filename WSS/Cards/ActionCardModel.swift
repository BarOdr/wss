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

struct ActionCardModel: Hashable {

    var isFront: Bool = true

    var imageName: String {
        isFront ? frontName : backName
    }

    let frontName: String
    let backName: String
    let cardType: ActionCardType
    let level: Int
    // file number, not sure if will be useful
    let number: Int
}

enum ActionCardType: Hashable {
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
