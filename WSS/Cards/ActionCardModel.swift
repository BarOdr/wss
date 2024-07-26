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

final class ActionCardModel: ObservableObject, Hashable, Codable {

    @Published var isDrawn: Bool = false {
        didSet {
            updateImageName()
            print("Is drawn: \(isDrawn)")
        }
    }

    @Published var imageName: String {
        didSet {
            print("imageName set: \(imageName)")
        }
    }

    let frontName: String
    var backName: String {
        didSet {
            updateImageName()
            print("backName set: \(backName)")
        }
    }
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
        self.imageName = ""
        self.updateImageName()
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

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isDrawn, forKey: .isDrawn)
        try container.encode(imageName, forKey: .imageName)
        try container.encode(frontName, forKey: .frontName)
        try container.encode(backName, forKey: .backName)
        try container.encode(cardType, forKey: .cardType)
        try container.encode(level, forKey: .level)
        try container.encode(number, forKey: .number)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isDrawn = try container.decode(Bool.self, forKey: .isDrawn)
        imageName = try container.decode(String.self, forKey: .imageName)
        frontName = try container.decode(String.self, forKey: .frontName)
        backName = try container.decode(String.self, forKey: .backName)
        cardType = try container.decode(ActionCardType.self, forKey: .cardType)
        level = try container.decode(Int.self, forKey: .level)
        number = try container.decode(Int.self, forKey: .number)
        self.updateImageName()
    }
    
    func update(backName: String) {
        self.backName = backName
    }

    private func updateImageName() {
        imageName = isDrawn ? frontName : backName
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
