//
//  ActionDeckView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import SwiftUI

final class ActionDeckViewModel: ObservableObject {

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
        deck[0].isDrawn = true
    }

    func draw(card: ActionCardModel) {
        guard let cardIndex = deck.firstIndex(of: card) else {
            print("Could not draw. Index not found.")
            return
        }
        print("Drawing card: \(card.number)")
        deck[cardIndex].isDrawn = true
    }

    func discardFirstCard() throws {
        print("Discarding card.")
        guard !deck.isEmpty else {
            print("Deck is empty.")
            throw DeckError.deckEmpty
        }
        let card = deck[0]
        deck.removeFirst()
        discarded.append(card)
    }

    func discard(card: ActionCardModel) {
        deck.removeAll { element in
            element == card
        }
    }
}

struct ActionDeckView: View {

    @EnvironmentObject var appDependencies: AppDependencies

    @StateObject var viewModel: ActionDeckViewModel

    var body: some View {
        ZStack {
            Image("wooden_background", bundle: .main)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            ForEach(Array(viewModel.deck.enumerated()), id: \.element) { index, card in
                CardView(card: card, discardBlock:
                            { card in
                    withAnimation {
                        viewModel.discard(card: card)
                    }
                }
                )
            }
        }
    }
}
