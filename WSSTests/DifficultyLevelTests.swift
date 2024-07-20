//
//  DifficultyLevelTests.swift
//  WSSTests
//
//  Created by Bartek Odrzywolek on 19/07/2024.
//

import XCTest
@testable import WSS

final class DifficultyLevelTests: XCTestCase {

    // TODO: - Implement tests
    func test_easy() {
        let difficulty = Difficulty.easy
        
        XCTAssertEqual(difficulty.generalActionCardsAmount(for: .one), 4)
        XCTAssertEqual(difficulty.generalActionCardsAmount(for: .two), 4)
        XCTAssertEqual(difficulty.generalActionCardsAmount(for: .three), 2)

        XCTAssertEqual(difficulty.advancedActionCardsAmount(for: .one), 1)
        XCTAssertEqual(difficulty.advancedActionCardsAmount(for: .two), 1)
        XCTAssertEqual(difficulty.advancedActionCardsAmount(for: .three), 1)

        XCTAssertEqual(difficulty.generalChallengesCardsAmount(for: .one), 2)
        XCTAssertEqual(difficulty.generalChallengesCardsAmount(for: .two), 2)
        XCTAssertEqual(difficulty.generalChallengesCardsAmount(for: .three), 1)

        XCTAssertEqual(difficulty.advancedChallengesCardsAmount(for: .one), 2)
        XCTAssertEqual(difficulty.advancedChallengesCardsAmount(for: .two), 2)
        XCTAssertEqual(difficulty.advancedChallengesCardsAmount(for: .three), 2)

        XCTAssertEqual(difficulty.legendaryHuntCardsAmount, 1)
        XCTAssertEqual(difficulty.challengesDeckSize, 11)
    }

    func test_medium() {
        let difficulty = Difficulty.medium

        XCTAssertEqual(difficulty.generalActionCardsAmount(for: .one), 3)
        XCTAssertEqual(difficulty.generalActionCardsAmount(for: .two), 3)
        XCTAssertEqual(difficulty.generalActionCardsAmount(for: .three), 3)

        XCTAssertEqual(difficulty.advancedActionCardsAmount(for: .one), 1)
        XCTAssertEqual(difficulty.advancedActionCardsAmount(for: .two), 1)
        XCTAssertEqual(difficulty.advancedActionCardsAmount(for: .three), 1)

        XCTAssertEqual(difficulty.generalChallengesCardsAmount(for: .one), 3)
        XCTAssertEqual(difficulty.generalChallengesCardsAmount(for: .two), 3)
        XCTAssertEqual(difficulty.generalChallengesCardsAmount(for: .three), 0)

        XCTAssertEqual(difficulty.advancedChallengesCardsAmount(for: .one), 2)
        XCTAssertEqual(difficulty.advancedChallengesCardsAmount(for: .two), 2)
        XCTAssertEqual(difficulty.advancedChallengesCardsAmount(for: .three), 2)

        XCTAssertEqual(difficulty.legendaryHuntCardsAmount, 2)
        XCTAssertEqual(difficulty.challengesDeckSize, 12)
    }

    func test_hard() {
        let difficulty = Difficulty.hard

        XCTAssertEqual(difficulty.generalActionCardsAmount(for: .one), 2)
        XCTAssertEqual(difficulty.generalActionCardsAmount(for: .two), 2)
        XCTAssertEqual(difficulty.generalActionCardsAmount(for: .three), 2)

        XCTAssertEqual(difficulty.advancedActionCardsAmount(for: .one), 1)
        XCTAssertEqual(difficulty.advancedActionCardsAmount(for: .two), 1)
        XCTAssertEqual(difficulty.advancedActionCardsAmount(for: .three), 1)

        XCTAssertEqual(difficulty.generalChallengesCardsAmount(for: .one), 3)
        XCTAssertEqual(difficulty.generalChallengesCardsAmount(for: .two), 3)
        XCTAssertEqual(difficulty.generalChallengesCardsAmount(for: .three), 0)

        XCTAssertEqual(difficulty.advancedChallengesCardsAmount(for: .one), 2)
        XCTAssertEqual(difficulty.advancedChallengesCardsAmount(for: .two), 2)
        XCTAssertEqual(difficulty.advancedChallengesCardsAmount(for: .three), 2)

        XCTAssertEqual(difficulty.legendaryHuntCardsAmount, 3)
        XCTAssertEqual(difficulty.challengesDeckSize, 12)
    }
}
