//
//  DifficultyLevel.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 19/07/2024.
//

import Foundation

enum Level: Int {
    case one = 1
    case two = 2
    case three = 3
}

enum Difficulty: String, CaseIterable, Identifiable {
    case easy
    case medium
    case hard

    // MARK: - Action cards

    var description: String {
        switch self {
        case .easy:
            return "EASY"
        case .medium:
            return "MEDIUM"
        case .hard:
            return "HARD"
        }
    }
    
    var id: String {
        "difficulty_\(rawValue)"
    }

    var legendaryHuntCardsAmount: Int {
        switch self {
        case .easy:
            return 1
        case .medium:
            return 2
        case .hard:
            return 3
        }
    }

    func generalActionCardsAmount(for level: Level) -> Int {
        switch level {
        case .one:
            return lvl1GeneralActionCardsAmount
        case .two:
            return lvl2GeneralActionCardsAmount
        case .three:
            return lvl3GeneralActionCardsAmount
        }
    }

    func advancedActionCardsAmount(for level: Level) -> Int {
        switch level {
        case .one:
            return lvl1AdvancedActionCardsAmount
        case .two:
            return lvl2AdvancedActionCardsAmount
        case .three:
            return lvl3AdvancedActionCardsAmount
        }
    }

    func generalChallengesCardsAmount(for level: Level) -> Int {
        switch level {
        case .one:
            return lvl1GeneralChallengeCardsAmount
        case .two:
            return lvl2GeneralChallengeCardsAmount
        case .three:
            return lvl3GeneralChallengeCardsAmount
        }
    }

    func advancedChallengesCardsAmount(for level: Level) -> Int {
        switch level {
        case .one:
            return lvl1AdvancedChallengeCardsAmount
        case .two:
            return lvl2AdvancedChallengeCardsAmount
        case .three:
            return lvl3AdvancedChallengeCardsAmount
        }
    }

    var challengesDeckSize: Int {
        generalChallengesCardsAmount(for: .one) +
        generalChallengesCardsAmount(for: .two) +
        generalChallengesCardsAmount(for: .three) +
        advancedChallengesCardsAmount(for: .one) +
        advancedChallengesCardsAmount(for: .two) +
        advancedChallengesCardsAmount(for: .three)
    }
}

fileprivate extension Difficulty {

    // Level 1
    var lvl1GeneralActionCardsAmount: Int {
        switch self {
        case .easy:
            return 4
        case .medium:
            return 3
        case .hard:
            return 2
        }
    }

    var lvl1AdvancedActionCardsAmount: Int {
        1
    }

    // Level 2
    var lvl2GeneralActionCardsAmount: Int {
        switch self {
        case .easy:
            4
        case .medium:
            3
        case .hard:
            2
        }
    }

    var lvl2AdvancedActionCardsAmount: Int {
        1
    }

    // Level 3
    var lvl3GeneralActionCardsAmount: Int {
        switch self {
        case .easy:
            2
        case .medium:
            3
        case .hard:
            2
        }
    }

    var lvl3AdvancedActionCardsAmount: Int {
        1
    }

    // MARK: - Challenge cards

    // Level 1
    var lvl1GeneralChallengeCardsAmount: Int {
        switch self {
        case .easy:
            2
        case .medium:
            3
        case .hard:
            3
        }
    }

    var lvl1AdvancedChallengeCardsAmount: Int {
        2
    }

    // Level 2
    var lvl2GeneralChallengeCardsAmount: Int {
        switch self {
        case .easy:
            2
        case .medium:
            3
        case .hard:
            3
        }
    }

    var lvl2AdvancedChallengeCardsAmount: Int {
        2
    }

    // Level 3
    var lvl3GeneralChallengeCardsAmount: Int {
        switch self {
        case .easy:
            1
        case .medium:
            0
        case .hard:
            0
        }
    }

    var lvl3AdvancedChallengeCardsAmount: Int {
        2
    }
}
