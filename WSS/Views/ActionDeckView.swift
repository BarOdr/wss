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
                addons: [],
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

    enum CardSide {
        case front
        case bottom
    }

    @EnvironmentObject var appDependencies: AppDependencies
    @State private var isSwiping = false

    @StateObject var viewModel: ActionDeckViewModel
    @State private var bottomCardOffset = CGSize.zero
    @State private var frontCardOffset = CGSize.zero
    @State private var isSwipedOff = false

    var body: some View {
        ZStack {
            Image("wooden_background", bundle: .main)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            let deck = viewModel.deckManager.deck
            if deck.count >= 1, let firstCard = deck.last {
                if deck.count >= 2 {
                    cardView(model: deck[deck.count - 2])
                }
                cardView(model: firstCard)
            }
        }
    }

    func cardView(model: ActionCardModel) -> some View {
        return CardView(model: model)
            .onTapGesture(count: 2) {
                try? viewModel.deckManager.drawFirstCard()
            }
            .offset(frontCardOffset)
            .gesture(
                cardOffScreenDragGesture()
            )
            .animation(.spring(), value: frontCardOffset)
    }

    func cardOffScreenDragGesture() -> some Gesture {
        DragGesture()
            .onChanged { gesture in
                frontCardOffset = gesture.translation
                isSwiping = true
            }
            .onEnded { _ in
                if abs(frontCardOffset.width) > 100 {
                    frontCardOffset.width = frontCardOffset.width > 0 ? 1000 : -1000
                    withAnimation {
                        try? viewModel.drawFirstCard()
                    }
                } else {
                    frontCardOffset = .zero
                }
                isSwiping = false
            }
    }
}

#Preview {
    ActionDeckView(viewModel: ActionDeckViewModel())
}
