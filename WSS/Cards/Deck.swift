//
//  Deck.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 26/07/2024.
//

import Foundation

enum ReversibleAction {
    case draw(card: ActionCardModel)
    case discard(card: ActionCardModel)
}

final class Deck: ObservableObject, Codable {
    @Published var remainingCards: [ActionCardModel] {
        didSet {
            remainingCount = remainingCards.count
            objectWillChange.send()
            print("Remaining cards did set")
        }
    }
    @Published var remainingCount: Int {
        didSet {
            objectWillChange.send()
            print("Remaining count set to: \(remainingCount)")
        }
    }
    @Published var discardedCards: [ActionCardModel] {
        didSet {
            discardedCount = discardedCards.count
            objectWillChange.send()
            print("Discarded cards did set")
        }
    }
    @Published var discardedCount: Int {
        didSet {
            objectWillChange.send()
            print("Discarded count set to: \(discardedCount)")
        }
    }
    let initialCount: Int

    init(remaining: [ActionCardModel], discarded: [ActionCardModel]) {
        self.initialCount = remaining.count
        self.remainingCards = remaining
        self.remainingCount = remaining.count
        self.discardedCards = discarded
        self.discardedCount = discarded.count
    }

    enum CodingKeys: String, CodingKey {
         case initialCount
         case deck
         case remainingCount
         case discarded
         case discardedCount
     }

     func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(initialCount, forKey: .initialCount)
         try container.encode(remainingCards, forKey: .deck)
         try container.encode(remainingCount, forKey: .remainingCount)
         try container.encode(discardedCards, forKey: .discarded)
         try container.encode(discardedCount, forKey: .discardedCount)
     }

     required init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
         initialCount = try container.decode(Int.self, forKey: .initialCount)
         remainingCards = try container.decode([ActionCardModel].self, forKey: .deck)
         remainingCount = try container.decode(Int.self, forKey: .remainingCount)
         discardedCards = try container.decode([ActionCardModel].self, forKey: .discarded)
         discardedCount = try container.decode(Int.self, forKey: .discardedCount)
     }

    var actions: [ReversibleAction] = []

    enum DeckError: Error {
        case deckEmpty
    }

    func draw(card: ActionCardModel) {
        print("About to draw card")
        guard let cardIndex = remainingCards.firstIndex(of: card) else {
            print("Could not draw. Index not found.")
            return
        }
        print("Drawing card: \(card.number)")
        let card = remainingCards[cardIndex].updating(isDrawn: true)
        remainingCards.remove(at: cardIndex)
        remainingCards.insert(card, at: cardIndex)
        actions.append(.draw(card: card))
        objectWillChange.send()
    }

    func discard(card: ActionCardModel) {
        print("About to discard a card")
        remainingCards.removeAll { element in
            let match = element == card
            if match {
                print("Removing card \(card.number)")
            }
            return match
        }
        discardedCards.append(card)
        actions.append(.discard(card: card))
        objectWillChange.send()
    }

    func undo() {
        print("About to undo")
        guard let action = actions.last else {
            print("Nothing to revert")
            return
        }
        switch action {
        case .discard(let card):
            print("Undoing discard action")
            discardedCards.removeLast()
            remainingCards.append(card)
        case .draw(let card):
            print("Undoing draw action")
            if let index = remainingCards.firstIndex(of: card) {
                remainingCards.remove(at: index)
                remainingCards.insert(card.updating(isDrawn: false), at: index)
            }
        }
        actions.removeLast()
        objectWillChange.send()
    }
}
