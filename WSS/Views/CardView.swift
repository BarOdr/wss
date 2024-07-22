//
//  CardView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import SwiftUI

final class CardViewModel: ObservableObject {

    @ObservedObject var card: ActionCardModel
    var discardBlock: (ActionCardModel) -> Void

    init(card: ActionCardModel, discardBlock: @escaping (ActionCardModel) -> Void) {
        self.card = card
        self.discardBlock = discardBlock
    }

    func draw() {
        self.card.isDrawn.toggle()
    }

    func discard() {
        self.discardBlock(card)
    }
}

struct CardView: View {

    @StateObject var viewModel: CardViewModel
    @State var offset: CGSize = .zero

    var body: some View {
        ZStack {
            Image(viewModel.card.imageName, bundle: .main)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .aspectRatio(contentMode: .fit)
                .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
            VStack {
                Text("\(viewModel.card.number)")
                Text("\(viewModel.card.isDrawn)")
            }
        }
        .onTapGesture(count: 2) {
            viewModel.card.isDrawn = true
        }
        .gesture(
            cardOffScreenDragGesture()
        )
        .animation(.spring(), value: offset)
        .offset(offset)
    }

    func cardOffScreenDragGesture() -> some Gesture {
        return DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
            }
            .onEnded { _ in
                if abs(offset.width) > 100 {
                    offset.width = offset.width > 0 ? 1000 : -1000
                    withAnimation {
                        viewModel.discard()
                    }
                } else {
                    offset = .zero
                }
            }
    }
}
