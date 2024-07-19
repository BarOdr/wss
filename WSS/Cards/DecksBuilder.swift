//
//  DecksBuilder.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 19/07/2024.
//

import Foundation

enum AddonType {
    case skellige
    case legendaryHunt
}

struct Addon {
    let addonType: AddonType
    let cards: [ActionCardModel]
}

struct Decks {
    let actionDeck: [ActionCardModel]
    let automaTrophies: [ActionCardModel]
    let challengesDeck: [ActionCardModel]
}

final class DecksBuilder {

    private let allBaseCards: [ActionCardModel]
    private let addons: [Addon]
    private let difficultyLevel: Difficulty

    init(allBaseCards: [ActionCardModel], addons: [Addon], difficultyLevel: Difficulty) {
        self.allBaseCards = allBaseCards
        self.difficultyLevel = difficultyLevel
        self.addons = addons
    }

    // MARK: - Public methods

    func buildDecks() -> Decks {
        let actionDeckTuple = buildActionDeck(for: difficultyLevel)
        let automaTrophiesTuple = buildAutomaTrophiesDeck(from: actionDeckTuple.remainingCards)
        let challengesDeck = automaTrophiesTuple.remainingCards.shuffled()
        return Decks(
            actionDeck: actionDeckTuple.actionDeck,
            automaTrophies: automaTrophiesTuple.pickedCards,
            challengesDeck: challengesDeck
        )
    }

    func buildActionDeck(for difficulty: Difficulty) -> (actionDeck: [ActionCardModel], remainingCards: [ActionCardModel]) {
        // we build action deck first so we pick from ALL action cards.
        // then we will pick 3 cards from the remaining 3 level cards. That will be automa trophies
        // all other remaining cards from this step will be challenges deck
        var allActionCards = allBaseCards

        // add 3 Skellige cards of each level (1/2/3) to the all cards deck, then shuffle the levels and remove 3 cards from each level
        // so that the final amount is the same as without Skellige addon
        if let skelligeAddon = addons.first(where: { $0.addonType == .skellige }) {
            allActionCards.append(contentsOf: skelligeAddon.cards)
        }

        // pick x cards of level 3 BASE
        let level3BaseActionCardsTuple = pickGeneralActionCards(from: allActionCards, for: difficulty, level: .three)
        // pick x cards of level 3 ADVANCED
        let level3AdvancedActionCardsTuple = pickAdvancedActionCards(
            from: level3BaseActionCardsTuple.remainingCards,
            for: difficulty,
            level: .three
        )

        var legendaryHuntCards: [ActionCardModel]?
        if let legendaryHuntAddon = addons.first(where: { $0.addonType == .legendaryHunt }) {
            legendaryHuntCards = legendaryHuntAddon.cards
        }
        // shuffle the above
        let level3ActionDeck = (level3BaseActionCardsTuple.pickedCards + level3AdvancedActionCardsTuple.pickedCards + (legendaryHuntCards ?? []))
            .shuffled()

        // pick x cards of level 2 BASE
        let level2BaseActionCardsTuple = pickGeneralActionCards(
            from: level3AdvancedActionCardsTuple.remainingCards,
            for: difficulty,
            level: .two
        )
        // pick x cards of level 2 ADVANCED
        let level2AdvancedActionCardsTuple = pickAdvancedActionCards(
            from: level2BaseActionCardsTuple.remainingCards,
            for: difficulty,
            level: .two
        )
        // shuffle the above
        let level2ActionDeck = (level2BaseActionCardsTuple.pickedCards + level2AdvancedActionCardsTuple.pickedCards)
            .shuffled()

        // pick x cards of level 1 BASE
        let level1BaseActionCardsTuple = pickGeneralActionCards(
            from: level2AdvancedActionCardsTuple.remainingCards,
            for: difficulty,
            level: .one
        )
        // pick x cards of level 1 ADVANCED
        let level1AdvancedActionCardsTuple = pickAdvancedActionCards(
            from: level1BaseActionCardsTuple.remainingCards,
            for: difficulty,
            level: .one
        )
        // shuffle the above
        let level1ActionDeck = (level1BaseActionCardsTuple.pickedCards + level1AdvancedActionCardsTuple.pickedCards)
            .shuffled()

        // put level 3 at the bottom, then level 2, then level 1
        let actionDeck = level3ActionDeck + level2ActionDeck + level1ActionDeck

        return (actionDeck, level1AdvancedActionCardsTuple.remainingCards)
    }

    func buildAutomaTrophiesDeck(from array: [ActionCardModel]) -> (pickedCards: [ActionCardModel], remainingCards: [ActionCardModel]) {
        let level3Cards = selectAllGeneralCards(from: array, for: .three) + selectAllAdvancedCards(from: array, for: .three)
        let automaTrophiesTuple = pickCards(from: level3Cards, amount: 3)
        let remainingCards = array.filter { cardModel in
            automaTrophiesTuple.pickedCards.contains(cardModel) == false
        }
        return (automaTrophiesTuple.pickedCards, remainingCards)
    }
    
    func skelligeAdjustedDeck(baseDeck: [ActionCardModel], skelligeDeck: [ActionCardModel]) -> [ActionCardModel] {
        let combinedDeck = baseDeck + skelligeDeck
        var level3Cards = (selectAllGeneralCards(from: combinedDeck, for: .three) + selectAllAdvancedCards(from: combinedDeck, for: .three))
            .shuffled()
        for _ in 1...3 {
            let cardToRemove = level3Cards.randomElement()
            level3Cards.removeAll { card in
                card == cardToRemove
            }
        }
        var level2Cards = (selectAllGeneralCards(from: combinedDeck, for: .two) + selectAllAdvancedCards(from: combinedDeck, for: .two))
            .shuffled()
        for _ in 1...3 {
            let cardToRemove = level2Cards.randomElement()
            level2Cards.removeAll { card in
                card == cardToRemove
            }
        }
        var level1Cards = (selectAllGeneralCards(from: combinedDeck, for: .one) + selectAllAdvancedCards(from: combinedDeck, for: .one))
            .shuffled()
        for _ in 1...3 {
            let cardToRemove = level1Cards.randomElement()
            level1Cards.removeAll { card in
                card == cardToRemove
            }
        }
        return (level3Cards + level2Cards + level1Cards).shuffled()
    }

    // MARK: - Private action deck methods

    private func pickGeneralActionCards(
        from array: [ActionCardModel],
        for difficulty: Difficulty,
        level: Level
    ) -> (
        pickedCards: [ActionCardModel],
        remainingCards: [ActionCardModel]
    ) {
        pickCards(from: array, amount: difficulty.generalActionCardsAmount(for: level))
    }

    private func pickAdvancedActionCards(
        from array: [ActionCardModel],
        for difficulty: Difficulty,
        level: Level
    ) -> (
        pickedCards: [ActionCardModel],
        remainingCards: [ActionCardModel]
    ) {
        pickCards(from: array, amount: difficulty.advancedActionCardsAmount(for: level))
    }

    // MARK: - Private challenges methods

    
    // MARK: - General methods

    private func selectAllGeneralCards(from array: [ActionCardModel], for level: Level) -> [ActionCardModel] {
        array.filter { card in
            switch card.cardType {
            case .baseGeneral:
                return card.level == level.rawValue
            default:
                return false
            }
        }
    }

    private func selectAllAdvancedCards(from array: [ActionCardModel], for level: Level) -> [ActionCardModel] {
        array.filter { card in
            switch card.cardType {
            case .baseAdvanced:
                return card.level == level.rawValue
            default:
                return false
            }
        }
    }

    private func pickCards(
        from array: [ActionCardModel],
        amount: Int
    ) -> (
        pickedCards: [ActionCardModel],
        remainingCards: [ActionCardModel]
    ) {
        var pickedCards: [ActionCardModel] = []
        var remainingCards = array

        for _ in 1...amount {
            guard let pseudorandomPick = remainingCards.randomElement() else {
                break
            }
            pickedCards.append(pseudorandomPick)
            remainingCards.removeAll { model in
                model == pseudorandomPick
            }
        }
        return (pickedCards, remainingCards)
    }
}
