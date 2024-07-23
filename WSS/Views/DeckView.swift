//
//  ActionDeckView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import SwiftUI

final class DeckViewModel: ObservableObject {

    enum DeckError: Error {
        case deckEmpty
    }

    init(deck: [ActionCardModel], discarded: [ActionCardModel]) {
        self.deck = deck
        self.discarded = discarded
        self.deckEmpty = deck.isEmpty
        self.initialArrayCount = deck.count
        self.remainingCards = deck.count
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
    @Published var initialArrayCount: Int
    @Published var remainingCards: Int

    func reloadLevel3Cards() {
        let level3Cards = discarded.filter { card in
            card.level == 3 || card.cardType == .legendaryHunt
        }.shuffled()
        level3Cards.forEach { card in
            card.isDrawn = false
        }
        discarded = []
        remainingCards = level3Cards.count
        initialArrayCount = level3Cards.count
        deck = level3Cards
    }

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
        remainingCards = deck.count
    }

    func discard(card: ActionCardModel) {
        deck.removeAll { element in
            element == card
        }
        discarded.append(card)
        remainingCards = deck.count
    }
}

struct DeckView: View {

    @EnvironmentObject var appDependencies: AppDependencies

    @StateObject var viewModel: DeckViewModel

    var body: some View {

        ZStack {
            Image("wooden_background", bundle: .main)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                ZStack {
                    ForEach(Array(viewModel.deck.enumerated()), id: \.element) { index, card in
                        CardView(card: card, discardBlock: { card in withAnimation { viewModel.discard(card: card) }})
                            .offset(x: CGFloat(index) * 1.00025, y: CGFloat(index) * -1.00025) // Adjust offset for a 3D effect
                            .shadow(color: Color.black.opacity(0.3), radius: CGFloat(viewModel.deck.count - index)) // Dynamic shadow)
                    }
                }
                if !viewModel.deckEmpty {
                    HStack {
                        Spacer()
                        Text("\(String(viewModel.remainingCards))/\(String(viewModel.initialArrayCount))")
                            .font(.witcherTextRegular(size: 20))
                            .foregroundStyle(.white)
                            .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
                    }
                }
            }

            if viewModel.deckEmpty {
                Button(action: {
                    withAnimation {
                        viewModel.reloadLevel3Cards()
                    }
                }, label: {
                    Text("Reload")
                        .font(.witcherHeader(size: 40))
                        .foregroundStyle(.white)
                })
            }
        }

    }
}
