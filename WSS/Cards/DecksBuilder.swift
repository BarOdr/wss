//
//  DecksBuilder.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 19/07/2024.
//

import Foundation

struct Decks {
    let actionDeck: [CardModel]
    let automaTrophies: [CardModel]
    let challengesDeck: [CardModel]
}

final class DecksBuilder {

    private let allCards: [CardModel]
    private let difficultyLevel: Difficulty

    init(allCards: [CardModel], difficultyLevel: Difficulty) {
        self.allCards = allCards
        self.difficultyLevel = difficultyLevel
    }

    // MARK: - Public methods

    func buildDecks() -> Decks {
        let actionDeckTuple = buildActionDeck(for: difficultyLevel)
        let automaTrophiesTuple = buildAutomaTrophiesDeck(from: actionDeckTuple.actionDeck)
        let challengesDeck = automaTrophiesTuple.remainingCards.shuffled()
        return Decks(
            actionDeck: actionDeckTuple.actionDeck,
            automaTrophies: automaTrophiesTuple.pickedCards,
            challengesDeck: challengesDeck
        )
    }

    func buildActionDeck(for difficulty: Difficulty) -> (actionDeck: [CardModel], remainingCards: [CardModel]) {
        // we build action deck first so we pick from ALL action cards.
        // then we will pick 3 cards from the remaining 3 level cards. That will be automa trophies
        // all other remaining cards from this step will be challenges deck
        let allActionCards = allCards

        // pick x cards of level 3 BASE
        let level3BaseActionCardsTuple = pickGeneralActionCards(from: allActionCards, for: difficulty, level: .three)
        // pick x cards of level 3 ADVANCED
        let level3AdvancedActionCardsTuple = pickAdvancedActionCards(from: allActionCards, for: difficulty, level: .three)
        // shuffle the above
        let level3ActionDeck = (level3BaseActionCardsTuple.pickedCards + level3AdvancedActionCardsTuple.pickedCards)
            .shuffled()

        // pick x cards of level 2 BASE
        let level2BaseActionCardsTuple = pickGeneralActionCards(from: allActionCards, for: difficulty, level: .two)
        // pick x cards of level 2 ADVANCED
        let level2AdvancedActionCardsTuple = pickAdvancedActionCards(from: allActionCards, for: difficulty, level: .two)
        // shuffle the above
        let level2ActionDeck = (level2BaseActionCardsTuple.pickedCards + level2AdvancedActionCardsTuple.pickedCards)
            .shuffled()

        // pick x cards of level 1 BASE
        let level1BaseActionCardsTuple = pickGeneralActionCards(from: allActionCards, for: difficulty, level: .one)
        // pick x cards of level 1 ADVANCED
        let level1AdvancedActionCardsTuple = pickAdvancedActionCards(from: allActionCards, for: difficulty, level: .one)
        // shuffle the above
        let level1ActionDeck = (level1BaseActionCardsTuple.pickedCards + level1AdvancedActionCardsTuple.pickedCards)
            .shuffled()

        let actionDeck = level3ActionDeck + level2ActionDeck + level1ActionDeck

        // put level 3 at the bottom, then level 2, then level 1

        let remainingCards = (level3BaseActionCardsTuple.remainingCards + 
                              level3AdvancedActionCardsTuple.remainingCards +
                              level2BaseActionCardsTuple.remainingCards +
                              level2AdvancedActionCardsTuple.remainingCards +
                              level1BaseActionCardsTuple.remainingCards +
                              level2AdvancedActionCardsTuple.remainingCards)
        return (actionDeck, remainingCards)
    }

    func buildAutomaTrophiesDeck(from array: [CardModel]) -> (pickedCards: [CardModel], remainingCards: [CardModel]) {
        pickCards(from: array, amount: 3)
    }
    
    // MARK: - Private action deck methods

    private func pickGeneralActionCards(
        from array: [CardModel],
        for difficulty: Difficulty,
        level: Level
    ) -> (
        pickedCards: [CardModel],
        remainingCards: [CardModel]
    ) {
        pickCards(from: array, amount: difficulty.generalActionCardsAmount(for: level))
    }

    private func pickAdvancedActionCards(
        from array: [CardModel],
        for difficulty: Difficulty,
        level: Level
    ) -> (
        pickedCards: [CardModel],
        remainingCards: [CardModel]
    ) {
        pickCards(from: array, amount: difficulty.advancedActionCardsAmount(for: level))
    }

    // MARK: - Private challenges methods

    
    // MARK: - General methods

    private func selectAllGeneralCards(from array: [CardModel], for level: Level) -> [CardModel] {
        array.filter { card in
            switch card.cardType {
            case .baseGeneral(let cardLevel, _):
                return cardLevel == level.rawValue
            default:
                return false
            }
        }
    }

    private func selectAllAdvancedCards(from array: [CardModel], for level: Level) -> [CardModel] {
        array.filter { card in
            switch card.cardType {
            case .baseAdvanced(let cardLevel, _):
                return cardLevel == level.rawValue
            default:
                return false
            }
        }
    }

    private func pickCards(
        from array: [CardModel],
        amount: Int
    ) -> (
        pickedCards: [CardModel],
        remainingCards: [CardModel]
    ) {
        var pickedCards: [CardModel] = []
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
