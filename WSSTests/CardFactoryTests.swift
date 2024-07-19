//
//  CardFactoryTests.swift
//  WSSTests
//
//  Created by Bartek Odrzywolek on 18/07/2024.
//

import XCTest
@testable import WSS

final class CardFactoryTests: XCTestCase {

    var sut: CardsFactory!

    override func setUp() {
        sut = CardsFactory()
    }

    override func tearDown() {
        sut = nil
    }

    func test_actionCardsQuantity() {
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
        XCTAssertEqual(legendaryHuntCards.count, 3)
    }
}
