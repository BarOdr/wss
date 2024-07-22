//
//  CardView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import SwiftUI

final class CardViewModel: ObservableObject {
    @Published var deckManager: DeckManager
    @ObservedObject var card: ActionCardModel

    init(deckManager: DeckManager, card: ActionCardModel) {
        self.deckManager = deckManager
        self.card = card
    }

    func draw() {
        self.deckManager.draw(card: card)
    }

    func discard() {
        self.deckManager.discard(card: card)
    }
}

struct CardView: View {

    @StateObject var viewModel: CardViewModel
    @State var offset: CGSize = .zero

    var body: some View {
        ZStack {
            Image(viewModel.card.imageName, bundle: .main)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .aspectRatio(contentMode: .fit)
                .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
            VStack {
                Text("\(viewModel.card.number)")
                Text("\(viewModel.card.isDrawn)")
                Text("\(isLast())")
            }
        }
        .onTapGesture(count: 2) {
            viewModel.card.isDrawn = true
        }
        .gesture(
            cardOffScreenDragGesture()
        )
        .animation(.spring(), value: offset)
        .offset(offset)
    }

    func isLast() -> Bool {
        if let indexOfCard = viewModel.deckManager.deck.firstIndex(of: viewModel.card) {
            return viewModel.deckManager.deck.last == viewModel.deckManager.deck[indexOfCard]
        } else {
            return false
        }
    }
    
    func cardOffScreenDragGesture() -> some Gesture {
        return DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
            }
            .onEnded { _ in
                if abs(offset.width) > 100 {
                    offset.width = offset.width > 0 ? 1000 : -1000
                    withAnimation {
                        viewModel.discard()
                    }
                } else {
                    offset = .zero
                }
            }
    }
}
