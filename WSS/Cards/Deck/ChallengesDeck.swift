//
//  ChallengesDeck.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 27/07/2024.
//

import Foundation

final class ChallengesDeck: Deck {

    private(set) var automaTrophies: [ActionCardModel]
    
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
        try container.encode(automaTrophies, forKey: .automaTrophies)
        try super.encode(to: encoder)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        automaTrophies = try container.decode([ActionCardModel].self, forKey: .automaTrophies)
        try super.init(from: decoder)
    }

    func addAutomaTrophyToDeck() {
        print("About to add automa trophy to challenges deck")
        guard let trophy = automaTrophies.randomElement() else {
            print("No trophy remaining")
            return
        }
        try? appendEncodedSelfToActions()
        automaTrophies.removeAll { element in
            element == trophy
        }
        let pseudorandomIndex = Int.random(in: 0...remainingCount - 1)
        remainingCards.insert(trophy, at: pseudorandomIndex)
        backup = remainingCards
        initialCount = remainingCount + discardedCount
    }

    override func restoreState(from data: Data) throws {
        try super.restoreState(from: data)
        let selfObject = try JSONDecoder().decode(Self.self, from: data)
        self.automaTrophies = selfObject.automaTrophies
    }
}
