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
                    .frame(height: 90)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
    }

    var accessoriesView: some View {
        HStack {
            Spacer()
            shuffleButton
            if !deck.automaTrophies.isEmpty {
                addAutomaTrophyButton
            }
            if deck.actionsCount != 0 && !deck.remainingCards.isEmpty {
                undoButton
            }
            if !deck.remainingCards.isEmpty {
                remainingCardsView
            }
        }
    }

    var addAutomaTrophyButton: some View {
        Button(action: {
            deck.addAutomaTrophyToDeck()
            withAnimation {
                print("Empty button pressed - implement reloading")
            }
        }, label: {
            Text("+trofeum")
                .font(.witcherTextRegular(size: 20))
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
        })
    }

    var shuffleButton: some View {
        Button(action: {
            deck.resetAndShuffle()
            withAnimation {
                print("Empty button pressed - implement reloading")
            }
        }, label: {
            Text("tasuj")
                .font(.witcherTextRegular(size: 20))
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

