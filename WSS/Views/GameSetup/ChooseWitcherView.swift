//
//  ScrollableGridView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 28/07/2024.
//

import SwiftUI

struct ChooseWitcherView: View {

    @State private var selectedCard: WitcherCardModel? = nil
    @State private var isCardEnlarged: Bool = false

    var witcherChosenBlock: (Witcher) -> Void

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    let cards: [WitcherCardModel] = {
        var array: [WitcherCardModel] = []
        for witcher in Witcher.allCases {
            array.append(WitcherCardModel(witcher: witcher))
        }
        return array
    }()

    var namespace: Namespace.ID

    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(cards, id: \.id) { card in
                        if selectedCard == nil || selectedCard?.id != card.id {
                            ActionableCardView(imageName: card.witcher.imageName, size: .big, singleTapGesture: {
                                withAnimation(.spring()) {
                                    selectedCard = card
                                    isCardEnlarged = true
                                }
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
                        selectedCard = nil
                    }
                    .zIndex(1)

                ActionableCardView(imageName: card.witcher.imageName, size: .big, doubleTapGesture: {
                    witcherChosenBlock(card.witcher)
                })
                .matchedGeometryEffect(id: card.id, in: namespace)
                .frame(maxWidth: UIScreen.main.bounds.width - 80)
                .shadow(radius: 20)
                .zIndex(2)
            }
        }
        .animation(.spring(), value: isCardEnlarged)
    }
}
