//
//  ActionDeckView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import SwiftUI

final class ActionDeckViewModel: ObservableObject {

    @Published var deckManager: DeckManager

    init() {
        let factory = CardsFactory()
        deckManager = DeckManager(
            deck: DecksBuilder(
                cardsFactory: factory,
                addons: [.skellige],
                difficultyLevel: .easy
            ).buildDecks().actionDeck,
            discarded: []
        )
    }

    func drawFirstCard() throws {
        try deckManager.drawFirstCard()
    }

    func discardFirstCard() throws {
        try deckManager.discardFirstCard()
    }

    init(deckManager: DeckManager) {
        self.deckManager = deckManager
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

            ForEach(Array(viewModel.deckManager.deck.enumerated()), id: \.element) { index, card in
                CardView(
                    viewModel: CardViewModel(
                        deckManager: viewModel.deckManager,
                        card: card
                    )
                )
            }
        }
    }
}
