//
//  ActionDeckView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import SwiftUI

struct DeckView: View {

    @EnvironmentObject var appDependencies: AppDependencies

    @StateObject var deck: Deck

    var body: some View {

        ZStack {
            VStack {
                ZStack {
                    cardsStack
                }
                if !deck.remainingCards.isEmpty {
                    HStack {
                        Spacer()
                        Button(action: {
                            deck.undo()
                        }, label: {
                            Text("Undo")
                                .font(.witcherTextRegular(size: 20))
                                .foregroundStyle(.white)
                        })
                        Text("\(String(deck.remainingCount))/\(String(deck.initialCount))")
                            .font(.witcherTextRegular(size: 20))
                            .foregroundStyle(.white)
                            .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
                    }
                }
            }

            if deck.remainingCards.isEmpty {
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

    var cardsStack: some View {
        ForEach(Array(deck.remainingCards.enumerated()), id: \.element) {
            index,
            card in
            CardView(card: card,
                     discardBlock: {
                card in
                deck.discard(
                    card: card
                )
                // disable animation for now
//                withAnimation {
//                    deck.discard(
//                        card: card
//                    )
//                }
            },
                     drawBlock: {
                card in
                deck.draw(
                    card: card
                )
                
                // disable animation for now
//                withAnimation {
//                    deck.draw(
//                        card: card
//                    )
//                }
            })
                .offset(x: CGFloat(index) * 1.00025, y: CGFloat(index) * -1.00025) // Adjust offset for a 3D effect
                .shadow(color: Color.black.opacity(0.3), radius: CGFloat(deck.remainingCards.count - index)) // Dynamic shadow)
        }
    }
}
