//
//  CardsStack.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 27/07/2024.
//

import SwiftUI

struct CardsStackView: View {
    var cards: [ActionCardModel]
    var discardBlock: (ActionCardModel) -> ()
    var drawBlock: (ActionCardModel) -> ()

    var body: some View {
        ForEach(Array(cards.enumerated()), id: \.element.id) {
            index,
            card in
            CardView(card: card,
                     discardBlock: {
                card in
                withAnimation {
                    discardBlock(card)
                }
            },
                     drawBlock: {
                card in
                withAnimation {
                    drawBlock(card)
                }
            })
                .offset(x: CGFloat(index) * 1.00025, y: CGFloat(index) * -1.00025) // Adjust offset for a 3D effect
                .shadow(color: Color.black.opacity(0.3), radius: CGFloat(cards.count - index)) // Dynamic shadow)
        }
    }
}
