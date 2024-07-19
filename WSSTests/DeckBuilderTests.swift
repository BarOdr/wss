//
//  DeckBuilderTests.swift
//  WSSTests
//
//  Created by Bartek Odrzywolek on 19/07/2024.
//

import XCTest
@testable import WSS

final class DeckBuilderTests: XCTestCase {

    func test_deckBuilder_easy() {
        // given
        let factory = CardsFactory(addonsTypes: [])
        let sut = DecksBuilder(allBaseCards: factory.buildDeck(), addons: [], difficultyLevel: .easy)

        // when
        let decks = sut.buildDecks()

        XCTAssertEqual(decks.actionDeck.count, 13)
        XCTAssertEqual(decks.automaTrophies.count, 3)
        XCTAssertEqual(decks.challengesDeck.count, 11)
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
