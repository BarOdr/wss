//
//  ChallengesDeck.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 27/07/2024.
//

import Foundation

final class ChallengesDeck: Deck {

    private var automaTrophies: [ActionCardModel]

    init(cards: [ActionCardModel], automaTrophies: [ActionCardModel], deckType: DeckType) {
        self.automaTrophies = automaTrophies
        super.init(cards: cards, deckType: deckType)
    }

    enum CodingKeys: String, CodingKey {
        case automaTrophies
        case initialCount
        case remainingCards
        case remainingCount
        case discardedCards
        case discardedCount
        case deckType
        case actions
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try super.encode(to: encoder)
        try container.encode(automaTrophies, forKey: .automaTrophies)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        automaTrophies = try container.decode([ActionCardModel].self, forKey: .automaTrophies)
        try super.init(from: decoder)
    }

    func addAutomaTrophyToDeck() {

    }

    func removeAutomaThrophyFromDeck() {

    }
}
