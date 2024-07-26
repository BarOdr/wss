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
        guard let cardIndex = deck.remaining.firstIndex(of: card) else {
            print("Could not draw. Index not found.")
            return
        }
        print("Drawing card: \(card.number)")
        let card = deck.remaining[cardIndex]
        card.isDrawn = true
        actions.append(.draw(card: card))
    }

    func discard(card: ActionCardModel) {
        print("About to discard a card")
        deck.remaining.removeAll { element in
            let match = element == card
            if match {
                print("Removing card \(card.number)")
            }
            return match
        }
        deck.discarded.append(card)
        actions.append(.discard(card: card))
    }

    func drawTopCard() throws {
        print("Drawing card.")
        guard let topCard = deck.remaining.last else {
            print("Deck empty.")
            throw DeckError.deckEmpty
        }
        topCard.isDrawn = true
        actions.append(.draw(card: topCard))
    }

    func discardTopCard() throws {
        print("Discarding card.")
        guard let topCard = deck.remaining.last else {
            print("Deck empty.")
            throw DeckError.deckEmpty
        }
        deck.remaining.removeLast()
        deck.discarded.append(topCard)
        actions.append(.discard(card: topCard))
    }

    func undo() {
        guard let action = actions.last else {
            print("Nothing to revert")
            return
        }
        switch action {
        case .discard(let card):
            deck.discarded.removeLast()
            deck.remaining.append(card)
        case .draw(let card):
            card.isDrawn = false
        }
        actions.removeLast()
    }
}
