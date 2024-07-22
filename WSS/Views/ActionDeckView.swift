//
//  ActionDeckView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import SwiftUI

final class ActionDeckViewModel: ObservableObject {

    @Published var deck: [ActionCardModel]

    init() {
        deck = DecksBuilder(
            cardsFactory: CardsFactory(),
            addons: [.skellige],
            difficultyLevel: .easy
        ).buildDecks().actionDeck
    }

    func drawFirstCard() throws {
        deck.first?.isDrawn.toggle()
    }

    func discardFirstCard() throws {
        deck.removeFirst()
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
                CardView(
                    viewModel: CardViewModel(card: card, discardBlock: { card in
                        viewModel.discard(card: card)
                    })
                )
            }
        }
    }
}
