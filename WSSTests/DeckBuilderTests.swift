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
        // action deck
        XCTAssertEqual(decks.actionDeck.count, 13)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 10)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 3)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 11)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 5)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 6)
    }

    func test_deckBuilder_medium_no_addons() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [], difficultyLevel: .medium)

        // when
        let decks = sut.buildDecks()

        // them
        // action deck
        XCTAssertEqual(decks.actionDeck.count, 12)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 9)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 3)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 12)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 6)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 6)
    }

    func test_deckBuilder_hard_no_addons() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [], difficultyLevel: .easy)

        // when
        let decks = sut.buildDecks()

        // them
        // action deck
        XCTAssertEqual(decks.actionDeck.count, 9)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 6)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 6)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 12)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 6)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 6)
    }

    func test_deckBuilder_easy_skellige() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [.skellige], difficultyLevel: .easy)

        // when
        let decks = sut.buildDecks()

        // them
        // action deck
        XCTAssertEqual(decks.actionDeck.count, 13)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 10)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 3)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 11)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 5)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 6)
    }

    func test_deckBuilder_medium_skellige() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [.skellige], difficultyLevel: .medium)

        // when
        let decks = sut.buildDecks()

        // them
        // action deck
        XCTAssertEqual(decks.actionDeck.count, 12)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 9)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 3)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 12)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 6)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 6)
    }

    func test_deckBuilder_hard_skellige() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [.skellige], difficultyLevel: .easy)

        // when
        let decks = sut.buildDecks()

        // them
        // action deck
        XCTAssertEqual(decks.actionDeck.count, 9)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 6)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 6)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 12)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 6)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 6)
    }

    func test_deckBuilder_easy_skellige_legendaryHunt() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [.skellige, .legendaryHunt], difficultyLevel: .easy)

        // when
        let decks = sut.buildDecks()

        // them
        // action deck
        XCTAssertEqual(decks.actionDeck.count, 14)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 10)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 3)
        XCTAssertEqual(decks.actionDeck.filter({ model in
            model.cardType == .legendaryHunt
        }).count, 1)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 11)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 5)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 6)
    }

    func test_deckBuilder_medium_skellige_legendaryHunt() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [.skellige, .legendaryHunt], difficultyLevel: .medium)

        // when
        let decks = sut.buildDecks()

        // them
        // action deck
        XCTAssertEqual(decks.actionDeck.count, 14)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 9)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 3)
        XCTAssertEqual(decks.actionDeck.filter({ model in
            model.cardType == .legendaryHunt
        }).count, 2)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 12)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 6)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 6)
    }

    func test_deckBuilder_hard_skellige_legendaryHunt() {
        // given
        let factory = CardsFactory()
        let sut = DecksBuilder(cardsFactory: factory, addons: [.skellige, .legendaryHunt], difficultyLevel: .easy)

        // when
        let decks = sut.buildDecks()

        // them
        // action deck
        XCTAssertEqual(decks.actionDeck.count, 12)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 6)
        XCTAssertEqual(decks.actionDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 6)
        XCTAssertEqual(decks.actionDeck.filter({ model in
            model.cardType == .legendaryHunt
        }).count, 3)

        // automa trophies
        XCTAssertEqual(decks.automaTrophies.count, 3)

        // challenges deck
        XCTAssertEqual(decks.challengesDeck.count, 12)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseGeneral
        }).count, 6)
        XCTAssertEqual(decks.challengesDeck.filter({ card in
            card.cardType == .baseAdvanced
        }).count, 6)
    }

    private func getGeneralCards(from array: [ActionCardModel]) -> [ActionCardModel] {
        array.filter { card in
            card.cardType == .baseGeneral
        }
    }

    private func getAdvancedCards(from array: [ActionCardModel]) -> [ActionCardModel] {
        array.filter { card in
            card.cardType == .baseAdvanced
        }
    }
}
