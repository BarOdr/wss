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

    var actions: [ReversibleAction] = []

    enum DeckError: Error {
        case deckEmpty
    }

    init(deck: Deck) {
        self.deck = deck
    }

    @Published var deck: Deck {
        didSet {
            print("Deck did set called")
            print($deck.count)
        }
    }

    func draw(card: ActionCardModel) {
        guard let cardIndex = deck.deck.firstIndex(of: card) else {
            print("Could not draw. Index not found.")
            return
        }
        print("Drawing card: \(card.number)")
        let card = deck.deck[cardIndex]
        card.isDrawn = true
        actions.append(ReversibleAction.draw(card: card))
    }

    func discard(card: ActionCardModel) {
        deck.deck.removeAll { element in
            element == card
        }
    }

    func drawTopCard() throws {
        print("Drawing card.")
        guard let topCard = deck.deck.last else {
            print("Deck empty.")
            throw DeckError.deckEmpty
        }
        topCard.isDrawn = true
        actions.append(ReversibleAction.draw(card: topCard))
    }

    func discardTopCard() throws {
        print("Discarding card.")
        guard let topCard = deck.deck.last else {
            print("Deck empty.")
            throw DeckError.deckEmpty
        }
        deck.deck.removeLast()
        deck.discarded.append(topCard)
        actions.append(ReversibleAction.discard(card: topCard))
    }

    func revertLastAction() {
        guard let action = actions.last else {
            print("Nothing to revert")
            return
        }
        switch action {
        case .discard(let card):
            deck.discarded.removeLast()
            deck.deck.append(card)
        case .draw(let card):
            card.isDrawn = false
        }
        actions.removeLast()
    }
}
