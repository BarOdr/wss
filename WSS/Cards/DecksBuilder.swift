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

    var cardFileNames: [String] {
        switch self {
        case .skellige:
            return CardFileNames.skelligeActionCards
        case .legendaryHunt:
            return CardFileNames.legendaryHuntActionCards
        }
    }
}

final class BaseDecks {
    let actionDeck: [ActionCardModel]
    let automaTrophies: [ActionCardModel]
    let challengesDeck: [ActionCardModel]
    init(
        actionDeck: [ActionCardModel],
        automaTrophies: [ActionCardModel],
        challengesDeck: [ActionCardModel]
    ) {
        self.actionDeck = actionDeck
        self.automaTrophies = automaTrophies
        self.challengesDeck = challengesDeck
    }
}

final class DecksBuilder {

    private let cardsFactory: CardsFactory
    private let addons: [AddonType]
    private let difficultyLevel: Difficulty
    private let witcher: Witcher

    init(
        cardsFactory: CardsFactory,
        addons: [AddonType],
        difficultyLevel: Difficulty,
        witcher: Witcher
    ) {
        self.cardsFactory = cardsFactory
        self.addons = addons
        self.difficultyLevel = difficultyLevel
        self.witcher = witcher
    }

    // MARK: - Public methods

    func buildDecks() -> BaseDecks {
        let actionDeckTuple = buildActionDeck(for: difficultyLevel)
        let automaTrophiesTuple = buildAutomaTrophiesDeck(from: actionDeckTuple.remainingCards)
        let challengesDeck = buildChallengesDeck(
            for: difficultyLevel,
            remainingCards: automaTrophiesTuple.remainingCards
        ).shuffled()
        return BaseDecks(
            actionDeck: actionDeckTuple.actionDeck,
            automaTrophies: automaTrophiesTuple.pickedCards,
            challengesDeck: challengesDeck
        )
    }

    func buildChallengesDeck(for difficulty: Difficulty, remainingCards: [ActionCardModel]) -> [ActionCardModel] {
        // TODO: - fix this, select according to the table how many cards there should be. The actual numbers might differ so don't unit test it so hard
        let deckSize = difficulty.challengesDeckSize
        let reducedArray = remainingCards.reduced(tolimit: deckSize)
        for card in reducedArray {
            card.update(backName: "back_\(witcher.rawValue)")
        }
        return reducedArray
    }

    func buildActionDeck(for difficulty: Difficulty) -> (actionDeck: [ActionCardModel], remainingCards: [ActionCardModel]) {
        // we build action deck first so we pick from ALL action cards.
        // then we will pick 3 cards from the remaining 3 level cards. That will be automa trophies
        // all other remaining cards from this step will be challenges deck
        var allActionCards = cardsFactory.buildBaseCards()

        // add 3 Skellige cards of each level (1/2/3) to the all cards deck, then shuffle the levels and remove 3 cards from each level
        // so that the final amount is the same as without Skellige addon
        if let _ = addons.first(where: { $0 == .skellige }) {
            let skelligeAdjustedDeck = skelligeAdjustedDeck(baseDeck: allActionCards, skelligeDeck: cardsFactory.buildSkelligeDeck())
            allActionCards = skelligeAdjustedDeck
        }

        // pick x cards of level 3 BASE
        let level3BaseActionCardsTuple = pickGeneralActionCards(from: allActionCards, for: difficulty, level: .three)
        // pick x cards of level 3 ADVANCED
        let level3AdvancedActionCardsTuple = pickAdvancedActionCards(
            from: level3BaseActionCardsTuple.remainingCards,
            for: difficulty,
            level: .three
        )

        // shuffle the above
        var level3ActionDeck = (level3BaseActionCardsTuple.pickedCards + level3AdvancedActionCardsTuple.pickedCards).shuffled()

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

        // if legendary hunt addon is selected, add appropriate amount to level 3 cards according to difficulty level
        if let _ = addons.first(where: { $0 == .legendaryHunt }) {
            var legendaryHuntCardsToAddToDeck: [ActionCardModel] = []
            let legendaryHuntAllCards = cardsFactory.buildLegendaryHuntDeck().shuffled()
            legendaryHuntCardsToAddToDeck = []
            for i in 0...difficultyLevel.legendaryHuntCardsAmount - 1 {
                legendaryHuntCardsToAddToDeck.append(legendaryHuntAllCards[i])
            }
            level3ActionDeck.append(contentsOf: legendaryHuntCardsToAddToDeck)
            level3ActionDeck = level3ActionDeck.shuffled()
        }

        // put level 3 at the bottom, then level 2, then level 1
        let actionDeck = level3ActionDeck + level2ActionDeck + level1ActionDeck

        return (actionDeck, level1AdvancedActionCardsTuple.remainingCards)
    }

    func buildAutomaTrophiesDeck(from array: [ActionCardModel]) -> (pickedCards: [ActionCardModel], remainingCards: [ActionCardModel]) {
        let level3Cards = selectAllGeneralCards(from: array, for: .three) + selectAllAdvancedCards(from: array, for: .three)
        let automaTrophiesTuple = pickCards(from: level3Cards, originalArray: array, amount: 3)
        let remainingCards = array.filter { cardModel in
            automaTrophiesTuple.pickedCards.contains(cardModel) == false
        }
        return (automaTrophiesTuple.pickedCards, remainingCards)
    }
    
    func skelligeAdjustedDeck(baseDeck: [ActionCardModel], skelligeDeck: [ActionCardModel]) -> [ActionCardModel] {
        let advancedCardsLv1 = selectAllAdvancedCards(from: baseDeck, for: .one)
        let advancedCardsLv2 = selectAllAdvancedCards(from: baseDeck, for: .two)
        let advancedCardsLv3 = selectAllAdvancedCards(from: baseDeck, for: .three)
        let advancedCardsToShuffleBackIntoAdjustedDeck = advancedCardsLv1 + advancedCardsLv2 + advancedCardsLv3

        let level3BaseCards = selectAllGeneralCards(from: baseDeck, for: .three)
        let skelligeLevel3Cards = selectAllSkelligeCards(from: skelligeDeck, for: .three)
        var level3Cards = (level3BaseCards + skelligeLevel3Cards)
            .shuffled()

        if level3Cards.count != 9 {
            assertionFailure("When combining with skellige, at some point there should be nine cards of every level")
        }

        level3Cards = level3Cards.shuffled()
        level3Cards.removeLast(3)

        let level2BaseCards = selectAllGeneralCards(from: baseDeck, for: .two)
        let skelligeLevel2Cards = selectAllSkelligeCards(from: skelligeDeck, for: .two)
        var level2Cards = (level2BaseCards + skelligeLevel2Cards)
            .shuffled()

        if level2Cards.count != 9 {
            assertionFailure("When combining with skellige, at some point there should be nine cards of every level")
        }

        level2Cards = level2Cards.shuffled()
        level2Cards.removeLast(3)

        let level1BaseCards = selectAllGeneralCards(from: baseDeck, for: .one)
        let skelligeLevel1Cards = selectAllSkelligeCards(from: skelligeDeck, for: .one)
        var level1Cards = (level1BaseCards + skelligeLevel1Cards)
            .shuffled()

        if level1Cards.count != 9 {
            assertionFailure("When combining with skellige, at some point there should be nine cards of every level")
        }
        
        level1Cards = level1Cards.shuffled()
        level1Cards.removeLast(3)

        let adjustedDeck = (level3Cards + level2Cards + level1Cards + advancedCardsToShuffleBackIntoAdjustedDeck).shuffled()

        if adjustedDeck.count != 27 {
            assertionFailure("When combining with skellige, adjusted deck should have the same amount of cards as without skellige")
        }

        return adjustedDeck
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
        let filteredArray = selectAllGeneralCards(from: array, for: level)
        return pickCards(from: filteredArray, originalArray: array, amount: difficulty.generalActionCardsAmount(for: level))
    }

    private func pickAdvancedActionCards(
        from array: [ActionCardModel],
        for difficulty: Difficulty,
        level: Level
    ) -> (
        pickedCards: [ActionCardModel],
        remainingCards: [ActionCardModel]
    ) {
        let filteredArray = selectAllAdvancedCards(from: array, for: level)
        return pickCards(from: filteredArray, originalArray: array, amount: difficulty.advancedActionCardsAmount(for: level))
    }

    // MARK: - Private challenges methods

    
    // MARK: - General methods

    private func selectAllGeneralCards(from array: [ActionCardModel], for level: Level) -> [ActionCardModel] {
        array.filter { card in
            switch card.cardType {
            case .baseGeneral, .skellige:
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

    private func selectAllSkelligeCards(from array: [ActionCardModel], for level: Level) -> [ActionCardModel] {
        array.filter { card in
            switch card.cardType {
            case .skellige:
                return card.level == level.rawValue
            default:
                return false
            }
        }
    }

    private func pickCards(
        from array: [ActionCardModel],
        originalArray: [ActionCardModel],
        amount: Int
    ) -> (
        pickedCards: [ActionCardModel],
        remainingCards: [ActionCardModel]
    ) {
        var filteredArray = array
        var pickedCards: [ActionCardModel] = []

        for _ in 1...amount {
            guard let pseudorandomPick = filteredArray.randomElement() else {
                assertionFailure("There was no cards to pick from! Probably shouldn't happen...")
                break
            }
            pickedCards.append(pseudorandomPick)
            filteredArray.removeAll { model in
                model == pseudorandomPick
            }
        }

        var remainingCards: [ActionCardModel] = originalArray
        for pickedCard in pickedCards {
            remainingCards.removeAll { card in
                pickedCard == card
            }
        }
        return (pickedCards, remainingCards)
    }
}
