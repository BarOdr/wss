//
//  CardFactoryTests.swift
//  WSSTests
//
//  Created by Bartek Odrzywolek on 18/07/2024.
//

import XCTest
@testable import WSS

final class CardFactoryTests: XCTestCase {

    func test_base_actionCardsQuantity() {
        let sut = CardsFactory(addonsTypes: [])
        let baseGeneralCards = sut.buildDeck().filter { model in
            model.cardType == .baseGeneral
        }
        XCTAssertEqual(baseGeneralCards.count, 18)
        
        let baseAdvancedCards = sut.buildDeck().filter { model in
            model.cardType == .baseAdvanced
        }
        XCTAssertEqual(baseAdvancedCards.count, 9)

        let skelligeCards = sut.buildDeck().filter { model in
            model.cardType == .skellige
        }
        XCTAssertEqual(skelligeCards.count, 0)

        let legendaryHuntCards = sut.buildDeck().filter { model in
            model.cardType == .legendaryHunt
        }
        XCTAssertEqual(legendaryHuntCards.count, 0)
    }

    func test_skellige_actionCardsQuantity() {
        let sut = CardsFactory(addonsTypes: [.skellige])
        let baseGeneralCards = sut.buildDeck().filter { model in
            model.cardType == .baseGeneral
        }
        XCTAssertEqual(baseGeneralCards.count, 18)

        let baseAdvancedCards = sut.buildDeck().filter { model in
            model.cardType == .baseAdvanced
        }
        XCTAssertEqual(baseAdvancedCards.count, 9)

        let skelligeCards = sut.buildDeck().filter { model in
            model.cardType == .skellige
        }
        XCTAssertEqual(skelligeCards.count, 9)

        let legendaryHuntCards = sut.buildDeck().filter { model in
            model.cardType == .legendaryHunt
        }
        XCTAssertEqual(legendaryHuntCards.count, 0)
    }

    func test_legendaryHunt_actionCardsQuantity() {
        let sut = CardsFactory(addonsTypes: [.legendaryHunt])
        let baseGeneralCards = sut.buildDeck().filter { model in
            model.cardType == .baseGeneral
        }
        XCTAssertEqual(baseGeneralCards.count, 18)

        let baseAdvancedCards = sut.buildDeck().filter { model in
            model.cardType == .baseAdvanced
        }
        XCTAssertEqual(baseAdvancedCards.count, 9)

        let skelligeCards = sut.buildDeck().filter { model in
            model.cardType == .skellige
        }
        XCTAssertEqual(skelligeCards.count, 0)

        let legendaryHuntCards = sut.buildDeck().filter { model in
            model.cardType == .legendaryHunt
        }
        XCTAssertEqual(legendaryHuntCards.count, 3)
    }
}
