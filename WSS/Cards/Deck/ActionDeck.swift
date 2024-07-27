//
//  ActionDeck.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 27/07/2024.
//

import Foundation

final class ActionDeck: Deck {
    // for action deck
    func resetWithLevelThreeCardsShuffled() {
        try? appendEncodedSelfToActions()
        remainingCards = discardedCards
            .filter { model in
                model.level == 3 || model.cardType == .legendaryHunt
            }
            .shuffled()
        discardedCards = []
        initialCount = remainingCards.count
    }
}
