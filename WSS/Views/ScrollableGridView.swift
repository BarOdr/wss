//
//  ScrollableGridView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 28/07/2024.
//

import SwiftUI

struct ScrollableGridView: View {
    let cards: [WitcherCardModel] = {
        var array: [WitcherCardModel] = []
        for witcher in Witcher.allCases {
            array.append(WitcherCardModel(imageName: "witcher_\(witcher.rawValue)"))
        }
        return array
    }()

    @State private var selectedCard: WitcherCardModel? = nil
    @State private var isCardEnlarged: Bool = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            WoodenBackgroundView()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(cards) { card in
                        WitcherCardView(card: card)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedCard = card
                                    isCardEnlarged = true
                                }
                            }
                            .zIndex(selectedCard == card && isCardEnlarged ? 1 : 0)
                    }
                }
                .padding()
            }

            if let card = selectedCard, isCardEnlarged {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isCardEnlarged = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                selectedCard = nil
                            }
                        }
                    }
                    .zIndex(2) // Ensure the overlay is on top

                WitcherCardView(card: card)
                    .frame(maxWidth: UIScreen.main.bounds.width - 80)
                    .shadow(radius: 20)
                    .transition(.scale(scale: 0.1, anchor: .center))
                    .zIndex(3) // Ensure the card is above the overlay
            }
        }
    }
}
