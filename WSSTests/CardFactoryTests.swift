//
//  CardFactoryTests.swift
//  WSSTests
//
//  Created by Bartek Odrzywolek on 18/07/2024.
//

import XCTest
@testable import WSS

final class CardFactoryTests: XCTestCase {

    func test_cardFactory() {
        let sut = CardsFactory()
        let baseGeneralCards = sut.buildBaseCards().filter { model in
            model.cardType == .baseGeneral
        }
        XCTAssertEqual(baseGeneralCards.count, 18)
        XCTAssertEqual(baseGeneralCards.filter({ card in
            card.level == 1
        }).count, 6)
        XCTAssertEqual(baseGeneralCards.filter({ card in
            card.level == 2
        }).count, 6)
        XCTAssertEqual(baseGeneralCards.filter({ card in
            card.level == 3
        }).count, 6)

        let baseAdvancedCards = sut.buildBaseCards().filter { model in
            model.cardType == .baseAdvanced
        }
        XCTAssertEqual(baseAdvancedCards.filter({ model in
            model.level == 1
        }).count, 3)
        XCTAssertEqual(baseAdvancedCards.filter({ model in
            model.level == 2
        }).count, 3)
        XCTAssertEqual(baseAdvancedCards.filter({ model in
            model.level == 3
        }).count, 3)

        XCTAssertEqual(baseAdvancedCards.count, 9)

        let skelligeCards = sut.buildSkelligeDeck()
        for card in skelligeCards {
            XCTAssertEqual(card.cardType, .skellige)
        }
        XCTAssertEqual(skelligeCards.count, 9)
        XCTAssertEqual(skelligeCards.filter({ model in
            model.level == 1
        }).count, 3)
        XCTAssertEqual(skelligeCards.filter({ model in
            model.level == 2
        }).count, 3)
        XCTAssertEqual(skelligeCards.filter({ model in
            model.level == 3
        }).count, 3)

        let legendaryHuntCards = sut.buildLegendaryHuntDeck()
        for card in legendaryHuntCards {
            XCTAssertEqual(card.cardType, .legendaryHunt)
        }
        XCTAssertEqual(legendaryHuntCards.count, 3)
        XCTAssertEqual(legendaryHuntCards.filter({ model in
            model.level == 3
        }).count, 3)
    }

}
