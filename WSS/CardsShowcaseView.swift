//
//  RootView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 14/07/2024.
//

import Foundation

import SwiftUI

final class CardsShowcaseViewModel: ObservableObject {
    @Published var cards: [ActionCardModel]

    init(factory: CardsFactory) {
        self.cards = factory.buildBaseCards()
    }
}

struct CardsShowcaseView: View {

    init(viewModel: CardsShowcaseViewModel) {
        self.viewModel = viewModel
    }

    private let viewModel: CardsShowcaseViewModel

    var body: some View {
        ZStack {
            Image("wooden_background", bundle: .main)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            ScrollView {
                ForEach(viewModel.cards, id: \.self) { card in
                    CardView(model: card)
                }
            }
        }

    }
}


