//
//  DeckBuilderTests.swift
//  WSSTests
//
//  Created by Bartek Odrzywolek on 19/07/2024.
//

import XCTest
@testable import WSS

final class DeckBuilderTests: XCTestCase {

    func test_deckBuilder_easy_no_addons() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [], difficultyLevel: .easy)

        // when
        let decks = sut.buildDecks()

        // them
        // all decks combined
        let allDeckCombined = (decks.actionDeck + decks.automaTrophies + decks.challengesDeck)
        XCTAssertEqual(allDeckCombined.count, 27)
        XCTAssertTrue(decks.actionDeck.isUnique)
        XCTAssertTrue(decks.automaTrophies.isUnique)
        XCTAssertTrue(decks.challengesDeck.isUnique)
        XCTAssertTrue(allDeckCombined.isUnique)
        XCTAssertEqual(getBaseGeneralCards(from: allDeckCombined).count, 18)
        XCTAssertEqual(getBaseAdvancedCards(from: allDeckCombined).count, 9)
        XCTAssertEqual(getSkelligeCards(from: allDeckCombined).count, 0)
        XCTAssertEqual(getLegendaryHuntCards(from: allDeckCombined).count, 0)

        // action deck
        XCTAssertEqual(decks.actionDeck.count, 13)

        XCTAssertEqual(getBaseGeneralCards(from: decks.actionDeck).count, 10)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.actionDeck).count, 3)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.actionDeck).count, 4)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.actionDeck).count, 4)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.actionDeck).count, 2)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.actionDeck).count, 1)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)
        XCTAssertEqual(getLevel3Cards(from: decks.automaTrophies).count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 11)

        XCTAssertEqual(getBaseGeneralCards(from: decks.challengesDeck).count, 5)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.challengesDeck).count, 6)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.challengesDeck).count, 2)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.challengesDeck).count, 2)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.challengesDeck).count, 1)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.challengesDeck).count, 2)
    }

    func test_deckBuilder_medium_no_addons() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [], difficultyLevel: .medium)

        // when
        let decks = sut.buildDecks()

        // them
        // all decks combined
        let allDeckCombined = (decks.actionDeck + decks.automaTrophies + decks.challengesDeck)
        XCTAssertEqual(allDeckCombined.count, 27)
        XCTAssertTrue(decks.actionDeck.isUnique)
        XCTAssertTrue(decks.automaTrophies.isUnique)
        XCTAssertTrue(decks.challengesDeck.isUnique)
        XCTAssertTrue(allDeckCombined.isUnique)
        XCTAssertEqual(getBaseGeneralCards(from: allDeckCombined).count, 18)
        XCTAssertEqual(getBaseAdvancedCards(from: allDeckCombined).count, 9)
        XCTAssertEqual(getSkelligeCards(from: allDeckCombined).count, 0)
        XCTAssertEqual(getLegendaryHuntCards(from: allDeckCombined).count, 0)

        // action deck
        XCTAssertEqual(decks.actionDeck.count, 12)

        XCTAssertEqual(getBaseGeneralCards(from: decks.actionDeck).count, 9)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.actionDeck).count, 3)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.actionDeck).count, 3)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.actionDeck).count, 3)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.actionDeck).count, 3)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.actionDeck).count, 1)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)
        XCTAssertEqual(getLevel3Cards(from: decks.automaTrophies).count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 12)

        XCTAssertEqual(getBaseGeneralCards(from: decks.challengesDeck).count, 6)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.challengesDeck).count, 6)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.challengesDeck).count, 3)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.challengesDeck).count, 3)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.challengesDeck).count, 0)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.challengesDeck).count, 2)
    }

    func test_deckBuilder_hard_no_addons() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [], difficultyLevel: .hard)

        // when
        let decks = sut.buildDecks()

        // them
        // all decks combined
        let allDeckCombined = (decks.actionDeck + decks.automaTrophies + decks.challengesDeck)
        XCTAssertEqual(allDeckCombined.count, 24)
        XCTAssertTrue(decks.actionDeck.isUnique)
        XCTAssertTrue(decks.automaTrophies.isUnique)
        XCTAssertTrue(decks.challengesDeck.isUnique)
        XCTAssertTrue(allDeckCombined.isUnique)
        XCTAssertEqual(getBaseGeneralCards(from: allDeckCombined).count, 15)
        XCTAssertEqual(getBaseAdvancedCards(from: allDeckCombined).count, 9)
        XCTAssertEqual(getSkelligeCards(from: allDeckCombined).count, 0)
        XCTAssertEqual(getLegendaryHuntCards(from: allDeckCombined).count, 0)

        // action deck
        XCTAssertEqual(decks.actionDeck.count, 9)

        XCTAssertEqual(getBaseGeneralCards(from: decks.actionDeck).count, 6)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.actionDeck).count, 3)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.actionDeck).count, 2)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.actionDeck).count, 2)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.actionDeck).count, 2)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.actionDeck).count, 1)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)
        XCTAssertEqual(getLevel3Cards(from: decks.automaTrophies).count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 12)

        XCTAssertEqual(getBaseGeneralCards(from: decks.challengesDeck).count, 6)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.challengesDeck).count, 6)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.challengesDeck).count, 3)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.challengesDeck).count, 3)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.challengesDeck).count, 0)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.challengesDeck).count, 2)
    }

    func test_deckBuilder_easy_skellige() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [.skellige], difficultyLevel: .easy)

        // when
        let decks = sut.buildDecks()

        // them
        // all decks combined
        let allDeckCombined = (decks.actionDeck + decks.automaTrophies + decks.challengesDeck)
        XCTAssertEqual(allDeckCombined.count, 27)
        XCTAssertTrue(decks.actionDeck.isUnique)
        XCTAssertTrue(decks.automaTrophies.isUnique)
        XCTAssertTrue(decks.challengesDeck.isUnique)
        XCTAssertTrue(allDeckCombined.isUnique)
        XCTAssertEqual((getBaseGeneralCards(from: allDeckCombined) + getSkelligeCards(from: allDeckCombined)).count, 18)
        XCTAssertEqual(getBaseAdvancedCards(from: allDeckCombined).count, 9)
        XCTAssertEqual(getLegendaryHuntCards(from: allDeckCombined).count, 0)

        // action deck
        XCTAssertEqual(decks.actionDeck.count, 13)

        XCTAssertEqual(getBaseGeneralCards(from: decks.actionDeck).count, 10)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.actionDeck).count, 3)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.actionDeck).count, 4)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.actionDeck).count, 4)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.actionDeck).count, 2)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.actionDeck).count, 1)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)
        XCTAssertEqual(getLevel3Cards(from: decks.automaTrophies).count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 11)

        XCTAssertEqual(getBaseGeneralCards(from: decks.challengesDeck).count, 5)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.challengesDeck).count, 6)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.challengesDeck).count, 2)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.challengesDeck).count, 2)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.challengesDeck).count, 1)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.challengesDeck).count, 2)
    }

    func test_deckBuilder_medium_skellige() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [.skellige], difficultyLevel: .medium)

        // when
        let decks = sut.buildDecks()

        // them
        // all decks combined
        let allDeckCombined = (decks.actionDeck + decks.automaTrophies + decks.challengesDeck)
        XCTAssertEqual(allDeckCombined.count, 27)
        XCTAssertTrue(decks.actionDeck.isUnique)
        XCTAssertTrue(decks.automaTrophies.isUnique)
        XCTAssertTrue(decks.challengesDeck.isUnique)
        XCTAssertTrue(allDeckCombined.isUnique)
        XCTAssertEqual((getBaseGeneralCards(from: allDeckCombined) + getSkelligeCards(from: allDeckCombined)).count, 18)
        XCTAssertEqual(getBaseAdvancedCards(from: allDeckCombined).count, 9)
        XCTAssertEqual(getLegendaryHuntCards(from: allDeckCombined).count, 0)

        // action deck
        XCTAssertEqual(decks.actionDeck.count, 12)

        XCTAssertEqual(getBaseGeneralCards(from: decks.actionDeck).count, 9)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.actionDeck).count, 3)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.actionDeck).count, 3)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.actionDeck).count, 3)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.actionDeck).count, 3)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.actionDeck).count, 1)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)
        XCTAssertEqual(getLevel3Cards(from: decks.automaTrophies).count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 12)

        XCTAssertEqual(getBaseGeneralCards(from: decks.challengesDeck).count, 6)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.challengesDeck).count, 6)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.challengesDeck).count, 3)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.challengesDeck).count, 3)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.challengesDeck).count, 0)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.challengesDeck).count, 2)
    }

    func test_deckBuilder_hard_skellige() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [.skellige], difficultyLevel: .hard)

        // when
        let decks = sut.buildDecks()

        // them
        // all decks combined
        let allDeckCombined = (decks.actionDeck + decks.automaTrophies + decks.challengesDeck)
        XCTAssertEqual(allDeckCombined.count, 24)
        XCTAssertTrue(decks.actionDeck.isUnique)
        XCTAssertTrue(decks.automaTrophies.isUnique)
        XCTAssertTrue(decks.challengesDeck.isUnique)
        XCTAssertTrue(allDeckCombined.isUnique)
        XCTAssertEqual((getBaseGeneralCards(from: allDeckCombined) + getSkelligeCards(from: allDeckCombined)).count, 15)
        XCTAssertEqual(getBaseAdvancedCards(from: allDeckCombined).count, 9)
        XCTAssertEqual(getLegendaryHuntCards(from: allDeckCombined).count, 0)

        // action deck
        XCTAssertEqual(decks.actionDeck.count, 9)

        XCTAssertEqual(getBaseGeneralCards(from: decks.actionDeck).count, 6)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.actionDeck).count, 3)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.actionDeck).count, 2)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.actionDeck).count, 2)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.actionDeck).count, 2)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.actionDeck).count, 1)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)
        XCTAssertEqual(getLevel3Cards(from: decks.automaTrophies).count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 12)

        XCTAssertEqual(getBaseGeneralCards(from: decks.challengesDeck).count, 6)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.challengesDeck).count, 6)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.challengesDeck).count, 3)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.challengesDeck).count, 3)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.challengesDeck).count, 0)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.challengesDeck).count, 2)
    }

    func test_deckBuilder_easy_skellige_legendary_hunt() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [.skellige, .legendaryHunt], difficultyLevel: .easy)

        // when
        let decks = sut.buildDecks()

        // them
        // all decks combined
        let allDeckCombined = (decks.actionDeck + decks.automaTrophies + decks.challengesDeck)
        XCTAssertEqual(allDeckCombined.count, 28)
        XCTAssertTrue(decks.actionDeck.isUnique)
        XCTAssertTrue(decks.automaTrophies.isUnique)
        XCTAssertTrue(decks.challengesDeck.isUnique)
        XCTAssertTrue(allDeckCombined.isUnique)
        XCTAssertEqual((getBaseGeneralCards(from: allDeckCombined) + getSkelligeCards(from: allDeckCombined)).count, 18)
        XCTAssertEqual(getBaseAdvancedCards(from: allDeckCombined).count, 9)
        XCTAssertEqual(getLegendaryHuntCards(from: allDeckCombined).count, 1)

        // action deck
        XCTAssertEqual(decks.actionDeck.count, 14)

        XCTAssertEqual(getBaseGeneralCards(from: decks.actionDeck).count, 10)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.actionDeck).count, 3)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.actionDeck).count, 4)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.actionDeck).count, 4)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.actionDeck).count, 2)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.actionDeck).count, 1)

        // legendary hunt
        XCTAssertEqual(getLevel3Cards(from: decks.actionDeck).count, 4)
        XCTAssertEqual(getLegendaryHuntCards(from: decks.actionDeck).count, 1)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)
        XCTAssertEqual(getLevel3Cards(from: decks.automaTrophies).count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 11)

        XCTAssertEqual(getBaseGeneralCards(from: decks.challengesDeck).count, 5)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.challengesDeck).count, 6)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.challengesDeck).count, 2)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.challengesDeck).count, 2)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.challengesDeck).count, 1)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.challengesDeck).count, 2)
    }

    func test_deckBuilder_medium_skellige_legendary_hunt() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [.skellige, .legendaryHunt], difficultyLevel: .medium)

        // when
        let decks = sut.buildDecks()

        // them
        // all decks combined
        let allDeckCombined = (decks.actionDeck + decks.automaTrophies + decks.challengesDeck)
        XCTAssertEqual(allDeckCombined.count, 29)
        XCTAssertTrue(decks.actionDeck.isUnique)
        XCTAssertTrue(decks.automaTrophies.isUnique)
        XCTAssertTrue(decks.challengesDeck.isUnique)
        XCTAssertTrue(allDeckCombined.isUnique)
        XCTAssertEqual((getBaseGeneralCards(from: allDeckCombined) + getSkelligeCards(from: allDeckCombined)).count, 18)
        XCTAssertEqual(getBaseAdvancedCards(from: allDeckCombined).count, 9)
        XCTAssertEqual(getLegendaryHuntCards(from: allDeckCombined).count, 2)

        // action deck
        XCTAssertEqual(decks.actionDeck.count, 14)

        XCTAssertEqual(getBaseGeneralCards(from: decks.actionDeck).count, 9)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.actionDeck).count, 3)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.actionDeck).count, 3)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.actionDeck).count, 3)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.actionDeck).count, 3)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.actionDeck).count, 1)

        // legendary hunt
        XCTAssertEqual(getLevel3Cards(from: decks.actionDeck).count, 6)
        XCTAssertEqual(getLegendaryHuntCards(from: decks.actionDeck).count, 2)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)
        XCTAssertEqual(getLevel3Cards(from: decks.automaTrophies).count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 12)

        XCTAssertEqual(getBaseGeneralCards(from: decks.challengesDeck).count, 6)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.challengesDeck).count, 6)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.challengesDeck).count, 3)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.challengesDeck).count, 3)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.challengesDeck).count, 0)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.challengesDeck).count, 2)
    }

    func test_deckBuilder_hard_skellige_legendary_hunt() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [.skellige, .legendaryHunt], difficultyLevel: .hard)

        // when
        let decks = sut.buildDecks()

        // them
        // all decks combined
        let allDeckCombined = (decks.actionDeck + decks.automaTrophies + decks.challengesDeck)
        XCTAssertEqual(allDeckCombined.count, 27)
        XCTAssertTrue(decks.actionDeck.isUnique)
        XCTAssertTrue(decks.automaTrophies.isUnique)
        XCTAssertTrue(decks.challengesDeck.isUnique)
        XCTAssertTrue(allDeckCombined.isUnique)
        XCTAssertEqual((getBaseGeneralCards(from: allDeckCombined) + getSkelligeCards(from: allDeckCombined)).count, 15)
        XCTAssertEqual(getBaseAdvancedCards(from: allDeckCombined).count, 9)
        XCTAssertEqual(getLegendaryHuntCards(from: allDeckCombined).count, 3)

        // action deck
        XCTAssertEqual(decks.actionDeck.count, 12)

        XCTAssertEqual(getBaseGeneralCards(from: decks.actionDeck).count, 6)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.actionDeck).count, 3)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.actionDeck).count, 2)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.actionDeck).count, 2)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.actionDeck).count, 1)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.actionDeck).count, 2)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.actionDeck).count, 1)

        // legendary hunt
        XCTAssertEqual(getLevel3Cards(from: decks.actionDeck).count, 6)
        XCTAssertEqual(getLegendaryHuntCards(from: decks.actionDeck).count, 3)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)
        XCTAssertEqual(getLevel3Cards(from: decks.automaTrophies).count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 12)

        XCTAssertEqual(getBaseGeneralCards(from: decks.challengesDeck).count, 6)
        XCTAssertEqual(getBaseAdvancedCards(from: decks.challengesDeck).count, 6)

        XCTAssertEqual(getLevel1GeneralCards(from: decks.challengesDeck).count, 3)
        XCTAssertEqual(getLevel1AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel2GeneralCards(from: decks.challengesDeck).count, 3)
        XCTAssertEqual(getLevel2AdvancedCards(from: decks.challengesDeck).count, 2)

        XCTAssertEqual(getLevel3GeneralCards(from: decks.challengesDeck).count, 0)
        XCTAssertEqual(getLevel3AdvancedCards(from: decks.challengesDeck).count, 2)
    }

    private func getBaseGeneralCards(from array: [ActionCardModel]) -> [ActionCardModel] {
        array.filter { card in
            card.cardType == .baseGeneral
        }
    }

    private func getBaseAdvancedCards(from array: [ActionCardModel]) -> [ActionCardModel] {
        array.filter { card in
            card.cardType == .baseAdvanced
        }
    }

    private func getSkelligeCards(from array: [ActionCardModel]) -> [ActionCardModel] {
        array.filter { card in
            card.cardType == .skellige
        }
    }

    private func getLegendaryHuntCards(from array: [ActionCardModel]) -> [ActionCardModel] {
        array.filter { card in
            card.cardType == .legendaryHunt && card.level == 3
        }
    }

    private func getLevel1GeneralCards(from array: [ActionCardModel]) -> [ActionCardModel] {
        array.filter { card in
            card.level == 1 && card.cardType == .baseGeneral
        }
    }

    private func getLevel1AdvancedCards(from array: [ActionCardModel]) -> [ActionCardModel] {
        array.filter { card in
            card.level == 1 && card.cardType == .baseAdvanced
        }
    }

    private func getLevel2GeneralCards(from array: [ActionCardModel]) -> [ActionCardModel] {
        array.filter { card in
            card.level == 2 && card.cardType == .baseGeneral
        }
    }

    private func getLevel2AdvancedCards(from array: [ActionCardModel]) -> [ActionCardModel] {
        array.filter { card in
            card.level == 2 && card.cardType == .baseAdvanced
        }
    }

    private func getLevel3GeneralCards(from array: [ActionCardModel]) -> [ActionCardModel] {
        array.filter { card in
            card.level == 3 && card.cardType == .baseGeneral
        }
    }

    private func getLevel3AdvancedCards(from array: [ActionCardModel]) -> [ActionCardModel] {
        array.filter { card in
            card.level == 3 && card.cardType == .baseAdvanced
        }
    }

    private func getLevel3Cards(from array: [ActionCardModel]) -> [ActionCardModel] {
        array.filter { card in
            card.level == 3
        }
    }
}
