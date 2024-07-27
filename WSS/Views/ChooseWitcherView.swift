//
//  ScrollableGridView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 28/07/2024.
//

import SwiftUI

struct ChooseWitcherView: View {
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

    @Namespace private var namespace

    var body: some View {
        ZStack {
            WoodenBackgroundView()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(cards) { card in
                        if selectedCard == nil || selectedCard?.id != card.id {
                            WitcherCardView(card: card)
                                .matchedGeometryEffect(id: card.id, in: namespace)
                                .shadow(radius: 10) // Add shadow to cards in grid
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedCard = card
                                        isCardEnlarged = true
                                    }
                                }
                                .zIndex(0) // Ensure the card in the grid is below the enlarged card
                        }
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
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            selectedCard = nil
                        }
                    }
                    .zIndex(1) // Ensure the overlay is above the grid

                WitcherCardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: namespace)
                    .frame(maxWidth: UIScreen.main.bounds.width - 80)
                    .shadow(radius: 20)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isCardEnlarged = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            selectedCard = nil
                        }
                    }
                    .zIndex(2) // Ensure the enlarged card is above the overlay
            }
        }
    }
}
