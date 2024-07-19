//
//  DeckBuilderTests.swift
//  WSSTests
//
//  Created by Bartek Odrzywolek on 19/07/2024.
//

import XCTest
@testable import WSS

final class DeckBuilderTests: XCTestCase {

    let factory = CardsFactory()

    func test_deckBuilder_easy() {
        // given
        let sut = DecksBuilder(allCards: factory.buildDeck(), difficultyLevel: .easy)

        // when
        let decks = sut.buildDecks()

        XCTAssertEqual(decks.actionDeck.count, 13)
        XCTAssertEqual(decks.automaTrophies.count, 3)
        XCTAssertEqual(decks.challengesDeck.count, 11)
    }

}
