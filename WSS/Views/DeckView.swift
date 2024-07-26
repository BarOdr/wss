//
//  ActionDeckView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import SwiftUI

final class DeckViewModel: ObservableObject {

    @Published var deckManager: DeckManager

    enum DeckError: Error {
        case deckEmpty
    }

    init(deckManager: DeckManager) {
        self.deckManager = deckManager
    }

    func draw(card: ActionCardModel) {
        deckManager.draw(card: card)
    }

    func discard(card: ActionCardModel) {
        deckManager.discard(card: card)
    }
}

struct DeckView: View {

    @EnvironmentObject var appDependencies: AppDependencies

    @StateObject var viewModel: DeckViewModel

    var body: some View {

        ZStack {
            VStack {
                ZStack {
                    ForEach(Array(viewModel.deckManager.deck.deck.enumerated()), id: \.element) { index, card in
                        CardView(card: card, discardBlock: { card in withAnimation { viewModel.discard(card: card) }})
                            .offset(x: CGFloat(index) * 1.00025, y: CGFloat(index) * -1.00025) // Adjust offset for a 3D effect
                            .shadow(color: Color.black.opacity(0.3), radius: CGFloat(viewModel.deckManager.deck.deck.count - index)) // Dynamic shadow)
                    }
                }
                if !viewModel.deckManager.deck.deck.isEmpty {
                    HStack {
                        Spacer()
                        Text("\(String(viewModel.deckManager.deck.remainingCount))/\(String(viewModel.deckManager.deck.initialCount))")
                            .font(.witcherTextRegular(size: 20))
                            .foregroundStyle(.white)
                            .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
                        Button(action: {

                        }, label: {
                            Text("Button")
                        })
                    }
                }
            }

            if viewModel.deckManager.deck.deck.isEmpty {
                Button(action: {
                    withAnimation {
                        print("Empty button pressed - implement reloading")
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
