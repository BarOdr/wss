//
//  Deck.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import Foundation

enum ReversibleAction {
    case draw(card: ActionCardModel)
    case discard(card: ActionCardModel)
}

final class DeckManager: ObservableObject {

    @Published var deck: Deck {
        didSet {
            print("Deck did set")
        }
    }
    var actions: [ReversibleAction] = []

    enum DeckError: Error {
        case deckEmpty
    }

    init(deck: Deck) {
        self.deck = deck
    }

    func draw(card: ActionCardModel) {
        print("About to draw card")
        guard let cardIndex = deck.remainingCards.firstIndex(of: card) else {
            print("Could not draw. Index not found.")
            return
        }
        print("Drawing card: \(card.number)")
        let card = deck.remainingCards[cardIndex]
        card.isDrawn = true
        actions.append(.draw(card: card))
    }

    func discard(card: ActionCardModel) {
        print("About to discard a card")
        deck.remainingCards.removeAll { element in
            let match = element == card
            if match {
                print("Removing card \(card.number)")
            }
            return match
        }
        deck.discardedCards.append(card)
        actions.append(.discard(card: card))
    }

    func drawTopCard() throws {
        print("Drawing card.")
        guard let topCard = deck.remainingCards.last else {
            print("Deck empty.")
            throw DeckError.deckEmpty
        }
        topCard.isDrawn = true
        actions.append(.draw(card: topCard))
    }

    func discardTopCard() throws {
        print("Discarding card.")
        guard let topCard = deck.remainingCards.last else {
            print("Deck empty.")
            throw DeckError.deckEmpty
        }
        deck.remainingCards.removeLast()
        deck.discardedCards.append(topCard)
        actions.append(.discard(card: topCard))
    }

    func undo() {
        guard let action = actions.last else {
            print("Nothing to revert")
            return
        }
        switch action {
        case .discard(let card):
            deck.discardedCards.removeLast()
            deck.remainingCards.append(card)
        case .draw(let card):
            card.isDrawn = false
        }
        actions.removeLast()
    }
}
