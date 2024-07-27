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
                ZStack {
                    if deck.remainingCards.isEmpty {
                        actionsResetWithLevelThreeCardsShuffled
                    } else {
                        cardsStack
                    }
                }
                HStack {
                    Spacer()
                    if deck.actionsCount != 0 && !deck.remainingCards.isEmpty {
                        undoButton
                    }
                    if !deck.remainingCards.isEmpty {
                        remainingCardsView
                    }
                }
            }
        }
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
            Text("cofnij")
                .font(.witcherTextRegular(size: 20))
                .foregroundStyle(.white)
        }).padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))

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
