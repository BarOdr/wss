//
//  CardFactoryTests.swift
//  WSSTests
//
//  Created by Bartek Odrzywolek on 18/07/2024.
//

import XCTest
@testable import WSS

extension CardType {
    enum SimpleCardType {
        case baseGeneral
        case baseAdvanced
        case skellige
        case legendaryHunt
        case witcherAbility
    }
    var caseWithoutAssociatedValues: SimpleCardType {
        switch self {
        case .baseGeneral:
            return .baseGeneral
        case .baseAdvanced:
            return .baseAdvanced
        case .skellige:
            return .skellige
        case .legendaryHunt:
            return .legendaryHunt
        case .witcherAbility:
            return .witcherAbility
        }
    }
}
final class CardFactoryTests: XCTestCase {

    var sut: CardsFactory!

    override func setUp() {
        sut = CardsFactory()
    }

    override func tearDown() {
        sut = nil
    }

    func testCardsQuantity() {
        let baseGeneralCards = sut.buildDeck().filter { model in
            model.cardType.caseWithoutAssociatedValues == .baseGeneral
        }
        XCTAssertEqual(baseGeneralCards.count, 18)
        
        let baseAdvancedCards = sut.buildDeck().filter { model in
            model.cardType.caseWithoutAssociatedValues == .baseAdvanced
        }
        XCTAssertEqual(baseAdvancedCards.count, 9)

        let skelligeCards = sut.buildDeck().filter { model in
            model.cardType.caseWithoutAssociatedValues == .skellige
        }
        XCTAssertEqual(skelligeCards.count, 9)

        let legendaryHuntCards = sut.buildDeck().filter { model in
            model.cardType.caseWithoutAssociatedValues == .legendaryHunt
        }
        XCTAssertEqual(legendaryHuntCards.count, 3)

        let witcherAbilityCards = sut.buildDeck().filter { model in
            model.cardType.caseWithoutAssociatedValues == .witcherAbility
        }
        XCTAssertEqual(witcherAbilityCards.count, 7)
    }
}
