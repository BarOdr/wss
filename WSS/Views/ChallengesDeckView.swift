//
//  ChallengesDeckView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 27/07/2024.
//

import SwiftUI

struct ChallengesDeckView: View {
    @EnvironmentObject var appDependencies: AppDependencies

    @StateObject var deck: ChallengesDeck

    var body: some View {

        ZStack {
            VStack {
                Spacer()
                ZStack {
                    if deck.remainingCards.isEmpty {

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
        HStack(spacing: 15) {
            if deck.actionsCount != 0 && !deck.remainingCards.isEmpty {
                undoButton
            }
            shuffleButton
            if !deck.automaTrophies.isEmpty {
                addAutomaTrophyButton
            }
            Spacer()
            if !deck.remainingCards.isEmpty {
                remainingCardsView
            }
        }
        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
    }

    var addAutomaTrophyButton: some View {
        Button(action: {
            deck.addAutomaTrophyToDeck()
            withAnimation {
                print("Empty button pressed - implement reloading")
            }
        }, label: {
            Image(systemName: "trophy.fill")
                .foregroundColor(.white)
        })
    }

    var undoButton: some View {
        Button(action: {
            deck.undo()
        }, label: {
            Image(systemName: "arrowshape.turn.up.backward.fill")
                .foregroundStyle(.white)
        })
    }

    var shuffleButton: some View {
        Button(action: {
            deck.resetAndShuffle()
            withAnimation {
                print("Empty button pressed - implement reloading")
            }
        }, label: {
            Image(systemName: "shuffle")
                .foregroundStyle(.white)
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
