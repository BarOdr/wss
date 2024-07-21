//
//  Deck.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import Foundation

final class DeckManager: ObservableObject {

    enum DeckError: Error {
        case deckEmpty
    }

    init(deck: [ActionCardModel], discarded: [ActionCardModel]) {
        self.deck = deck
        self.discarded = discarded
        self.deckEmpty = deck.isEmpty
    }

    @Published var deck: [ActionCardModel] {
        didSet {
            print("Deck did set called")
            print(deck.count)
            deckEmpty = deck.isEmpty
        }
    }
    @Published var discarded: [ActionCardModel]
    @Published var deckEmpty: Bool


    func drawFirstCard() throws {
        print("Drawing card.")
        guard !deck.isEmpty else {
            print("Deck empty.")
            throw DeckError.deckEmpty
        }
        deck.last?.isDrawn = true
    }

    func discardFirstCard() throws {
        print("Discarding card.")
        guard !deck.isEmpty else {
            print("Deck is empty.")
            throw DeckError.deckEmpty
        }
        let card = deck[0]
        deck.removeLast()
        discarded.append(card)
    }
}
