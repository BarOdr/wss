//
//  CardsFactory.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 19/07/2024.
//

import Foundation

struct CardsFactory {

    private let actionCardBack = "back_automa"

    func buildDeck() -> [CardModel] {
        var cards: [CardModel] = []
        for cardFileName in CardFileNames.array {
            let strippedFileName = cardFileName.replacingOccurrences(of: ".jpg", with: "")
            let components = getComponents(for: strippedFileName)
            guard
                let categoryString = components.first,
                let category = CardCategory(rawValue: categoryString) else {
                continue
            }
            if let card = getCard(for: category, fileName: strippedFileName) {
                cards.append(card)
            } else {
                print("No card for \(category), \(strippedFileName). \(#line)")
            }
        }
        return cards
    }

    private func getCard(for category: CardCategory, fileName: String) -> CardModel? {
        switch category {
        case .baseAction:
            return getActionCard(for: fileName, category: category)
        case .witcher:
            return getWitcherCard(for: fileName)
        case .legendaryHuntAction:
            return getActionCard(for: fileName, category: category)
        case .skelligeAction:
            return getActionCard(for: fileName, category: category)
        }
    }

    private func getWitcherCard(for string: String) -> CardModel? {
        let components = getComponents(for: string)
        guard
            components.count > 1,
            let witcher = Witcher(rawValue: components[1])
        else {
            print("No card for \(string). \(#line)")
            return nil
        }
        return CardModel(frontName: string,
                         backName: "back_\(witcher.rawValue)",
                         cardType: .witcherAbility(witcher: witcher))
    }

    // base (general / advanced) / skellige / legendary hunt
    private func getActionCard(for string: String, category: CardCategory) -> CardModel? {
        let components = getComponents(for: string)
        guard components.count > 3 else {
            print("No card for \(string). \(#line)")
            return nil
        }
        switch category {
        case .baseAction:
            return getBaseCard(for: string)
        case .skelligeAction:
            return getSkelligeCard(for: string)
        case .legendaryHuntAction:
            return getLegendaryHuntCard(for: string)
        default:
            return nil
        }
    }

    private func getBaseCard(for string: String) -> CardModel? {
        let components = getComponents(for: string)
        guard components.count > 4, let subtype = CardSubtype(rawValue: components[2]) else {
            return nil
        }
        guard
            let cardNumber = Int(components[1]),
            let cardLevel = Int(components[4]) else {
            return nil
        }

        switch subtype {
        case .general:
            return CardModel(
                frontName: string,
                backName: actionCardBack,
                cardType: .baseGeneral(level: cardLevel, number: cardNumber)
            )
        case .advanced:
            return CardModel(
                frontName: string,
                backName: actionCardBack,
                cardType: .baseAdvanced(
                    level: cardLevel,
                    number: cardNumber
                )
            )
        }
    }

    private func getSkelligeCard(for string: String) -> CardModel? {
        let components = getComponents(for: string)
        guard components.count > 4 else {
            return nil
        }
        guard
            let cardNumber = Int(components[1]),
            let cardLevel = Int(components[4]) else {
            return nil
        }
        return CardModel(
            frontName: string,
            backName: actionCardBack,
            cardType: .skellige(
                level: cardLevel,
                number: cardNumber
            )
        )
    }

    private func getLegendaryHuntCard(for string: String) -> CardModel? {
        let components = getComponents(for: string)
        guard components.count > 3 else {
            return nil
        }
        guard
            let cardNumber = Int(components[1]),
            let cardLevel = Int(components[3]) else {
            return nil
        }
        return CardModel(
            frontName: string,
            backName: actionCardBack,
            cardType: .legendaryHunt(level: cardLevel, number: cardNumber)
        )
    }

    private func getComponents(for string: String) -> [String] {
        string.components(separatedBy: "_").map {
            $0.replacingOccurrences(of: ".jpg", with: "")
        }
    }
}
