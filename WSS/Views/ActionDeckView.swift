//
//  ActionDeckView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import SwiftUI

struct ActionDeckView: View {
    @EnvironmentObject var appDependencies: AppDependencies

    @StateObject var deck: ActionDeck

    var body: some View {

        ZStack {
            VStack {
                Spacer()
                ZStack {
                    if deck.remainingCards.isEmpty {
                        actionsResetWithLevelThreeCardsShuffled
                    } else {
                        cardsStack
                    }
                }
                accessoriesView
                    .frame(height: 70)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
    }

    var accessoriesView: some View {
        HStack(spacing: 10) {
            if deck.actionsCount != 0 && !deck.remainingCards.isEmpty {
                undoButton
            }
            Spacer()
            if !deck.remainingCards.isEmpty {
                remainingCardsView
            }
        }
        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
    }

    var actionsResetWithLevelThreeCardsShuffled: some View {
        Button(action: {
            deck.resetWithLevelThreeCardsShuffled()
            withAnimation {
                print("Empty button pressed - implement reloading")
            }
        }, label: {
            Text("Reload")
                .font(.witcherHeader(size: 40))
                .foregroundStyle(.white)
        })
    }

    var undoButton: some View {
        Button(action: {
            deck.undo()
        }, label: {
            Image(systemName: "arrowshape.turn.up.backward.fill")
                .foregroundColor(.white)
        })

    }

    var remainingCardsView: some View {
        RemainingCardsCountView(
            remainingCount: deck.remainingCount,
            initialCount: deck.initialCount
        )
    }

    var cardsStack: some View {
        CardsStackView(cards: deck.remainingCards) { card in
            deck.discard(card: card)
        } drawBlock: { card in
            deck.draw(card: card)
        }
    }
}
