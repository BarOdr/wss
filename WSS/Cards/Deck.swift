//
//  Deck.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 26/07/2024.
//

import Foundation

// values associated with cases are values to restore on undo.
enum ReversibleAction: Codable {
    case actionDeckLevelThreeRespawn(cards: [ActionCardModel], initialCount: Int)
    case draw(card: ActionCardModel)
    case discard(card: ActionCardModel)
}

enum DeckType: Codable {
    case actions
    case challenges
}

final class Deck: ObservableObject, Codable {
    @Published var remainingCards: [ActionCardModel] {
        didSet {
            remainingCount = remainingCards.count
            print("Remaining cards did set")
        }
    }
    @Published var remainingCount: Int {
        didSet {
            print("Remaining count set to: \(remainingCount)")
        }
    }
    @Published var discardedCards: [ActionCardModel] {
        didSet {
            discardedCount = discardedCards.count
            print("Discarded cards did set")
        }
    }
    @Published var discardedCount: Int {
        didSet {
            print("Discarded count set to: \(discardedCount)")
        }
    }
    @Published var initialCount: Int

    private let backup: [ActionCardModel]
    private let deckType: DeckType
//    private var actions: [ReversibleAction] = []
    var actions: [Data] = []

    init(cards: [ActionCardModel], deckType: DeckType) {
        self.initialCount = cards.count
        self.remainingCards = cards
        self.remainingCount = cards.count
        self.backup = cards
        self.discardedCards = []
        self.discardedCount = 0
        self.deckType = deckType
    }

    enum CodingKeys: String, CodingKey {
        case initialCount
        case remainingCards
        case remainingCount
        case discardedCards
        case discardedCount
        case deckType
        case actions
    }

     func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(initialCount, forKey: .initialCount)
         try container.encode(remainingCards, forKey: .remainingCards)
         try container.encode(remainingCount, forKey: .remainingCount)
         try container.encode(discardedCards, forKey: .discardedCards)
         try container.encode(discardedCount, forKey: .discardedCount)
         try container.encode(deckType, forKey: .deckType)
         let emptyActions: [Data] = []
         try container.encode(emptyActions, forKey: .actions)
     }

     required init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
         initialCount = try container.decode(Int.self, forKey: .initialCount)
         remainingCards = try container.decode([ActionCardModel].self, forKey: .remainingCards)
         backup = try container.decode([ActionCardModel].self, forKey: .remainingCards)
         remainingCount = try container.decode(Int.self, forKey: .remainingCount)
         discardedCards = try container.decode([ActionCardModel].self, forKey: .discardedCards)
         discardedCount = try container.decode(Int.self, forKey: .discardedCount)
         deckType = try container.decode(DeckType.self, forKey: .deckType)
         actions = []
     }


    enum DeckError: Error {
        case deckEmpty
    }

    func draw(card: ActionCardModel) {
        try! appendEncodedSelfToActions()
        print("About to draw card")
        guard let cardIndex = remainingCards.firstIndex(of: card) else {
            print("Could not draw. Index not found.")
            return
        }
        print("Drawing card: \(card.number)")
        let card = remainingCards[cardIndex].updating(isDrawn: true)
        remainingCards.remove(at: cardIndex)
        remainingCards.insert(card, at: cardIndex)
    }

    private func appendEncodedSelfToActions() throws {
        let state = try JSONEncoder().encode(self)
        actions.append(state)
    }

    private func restoreState(from data: Data) throws {
        let selfObject = try JSONDecoder().decode(Self.self, from: data)
        self.initialCount = selfObject.initialCount
        self.remainingCards = selfObject.remainingCards
        self.remainingCount = selfObject.remainingCount
        self.discardedCards = selfObject.discardedCards
        self.discardedCount = selfObject.discardedCount
    }

    func discard(card: ActionCardModel) {
        try! appendEncodedSelfToActions()
        print("About to discard a card")
        remainingCards.removeAll { element in
            let match = element == card
            if match {
                print("Removing card \(card.number)")
            }
            return match
        }
        discardedCards.append(card)
//        if remainingCards.isEmpty, deckType == .actions {
//            resetWithLevelThreeCardsShuffled()
//        }
    }

    func undo() {
        print("About to undo")
        guard let previousState = actions.last else {
            print("Nothing to undo")
            return
        }
        try! restoreState(from: previousState)
        actions.removeLast()
//        guard let action = actions.last else {
//            print("Nothing to revert")
//            return
//        }
//        switch action {
//        case .actionDeckLevelThreeRespawn(let cards, let initialCount):
//            print("Undoing level three respawn action")
//            guard let lastCard = cards.last else {
//                return
//            }
//            remainingCards = [lastCard]
//            var discarded = cards
//            discarded.removeLast()
//
//            discardedCards = discarded
//            // in this case, at this point, the last action will be drawing last card
//            // we should automatically undo it
//            actions.removeLast()
//            self.initialCount = initialCount
//        case .discard(let card):
//            print("Undoing discard action")
//            if !discardedCards.isEmpty {
//                discardedCards.removeLast()
//            }
//            remainingCards.append(card)
//            actions.removeLast()
//        case .draw(let card):
//            print("Undoing draw action")
//            if let index = remainingCards.firstIndex(of: card) {
//                remainingCards.remove(at: index)
//                remainingCards.insert(card.updating(isDrawn: false), at: index)
//                actions.removeLast()
//            }
//        }
    }

    // for action deck
    func resetWithLevelThreeCardsShuffled() {
        try! appendEncodedSelfToActions()
        remainingCards = discardedCards
            .filter { model in
                model.level == 3 || model.cardType == .legendaryHunt
            }
            .shuffled()
        discardedCards = []
        initialCount = remainingCards.count
    }

    func resetWithOriginalOrder() {
        remainingCards = backup
        discardedCards = []
    }

    func resetAndShuffle() {
        remainingCards = backup.shuffled()
        discardedCards = []
    }

    func addAutomaTrophy() {
        
    }

    func removeAutomaThropies() {
        
    }
}
