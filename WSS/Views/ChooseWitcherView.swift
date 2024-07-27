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
                            WitcherCardView(card: card, singleTapAction: {
                                withAnimation(.spring()) {
                                    selectedCard = card
                                    isCardEnlarged = true
                                }
                            }, doubleTapAction: {
                                // Handle double tap action
                                print("Double tapped on card: \(card.id)")
                            })
                            .matchedGeometryEffect(id: card.id, in: namespace)
                            .shadow(radius: 10)
                            .zIndex(0)
                        }
                    }
                }
                .padding()
            }

            if let card = selectedCard, isCardEnlarged {
                // Background overlay to detect taps outside the card
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
                    .zIndex(1)

                WitcherCardView(card: card, doubleTapAction: {
                    // Handle double tap action when card is enlarged
                    print("Double tapped on enlarged card: \(card.id)")
                })
                .matchedGeometryEffect(id: card.id, in: namespace)
                .frame(maxWidth: UIScreen.main.bounds.width - 80)
                .shadow(radius: 20)
                .onTapGesture(count: 2) {
                    print("Double tapped on enlarged card: \(card.id)")
                }
                .zIndex(2)
            }
        }
        .animation(.spring(), value: isCardEnlarged)
    }
}
