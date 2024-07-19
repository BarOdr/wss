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

struct CardView: View {

    @State var model: ActionCardModel

    var body: some View {
        Image(model.imageName, bundle: .main)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .aspectRatio(contentMode: .fit)
            .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
            .onTapGesture {
                model.isFront.toggle()
            }
    }
}
