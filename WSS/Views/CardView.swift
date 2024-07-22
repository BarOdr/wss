//
//  CardView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import SwiftUI

final class CardViewModel: ObservableObject {
    @Published var card: ActionCardModel
    var discardBlock: (ActionCardModel) -> ()

    init(card: ActionCardModel, discardBlock: @escaping (ActionCardModel) -> ()) {
        self.card = card
        self.discardBlock = discardBlock
    }

    func draw() {
        card.isDrawn.toggle()
    }

    func discard() {
        discardBlock(card)
    }
}

struct CardView: View {

    @State var offset: CGSize = .zero

    @ObservedObject var card: ActionCardModel
    var discardBlock: (ActionCardModel) -> ()

    var body: some View {
        ZStack {
            Image(card.imageName, bundle: .main)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .aspectRatio(contentMode: .fit)
                .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
        }
        .onTapGesture(count: 2) {
            card.isDrawn = true
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
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            discardBlock(card)
                        }
                    }
                } else {
                    offset = .zero
                }
            }
    }
}
