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

    @State private var offset: CGSize = .zero
    @State private var isLifted = false
    @State private var scale: CGFloat = 1.0
    @State private var rotationAngle: Double = 0.0
    @State private var isImageVisible = true

    @ObservedObject var card: ActionCardModel
    var discardBlock: (ActionCardModel) -> ()

    var body: some View {
        ZStack {
            Image(card.imageName, bundle: .main)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .aspectRatio(contentMode: .fit)
                .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
                .scaleEffect(x: -1, y: 1)
                .scaleEffect(scale)
                .rotation3DEffect(
                    .degrees(rotationAngle),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
        }
        .onTapGesture(count: 2) {
            performDrawAnimation()
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

    func performDrawAnimation() {
        guard card.isDrawn == false else {
            return
        }
        withAnimation(.easeInOut(duration: 0.2)) {
            isLifted = true
            scale = 1.1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeInOut(duration: 0.25)) {
                rotationAngle = 90
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            isImageVisible = false
            card.isDrawn = true
            isImageVisible = true

            withAnimation(.easeInOut(duration: 0.25)) {
                rotationAngle = 180
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(.easeInOut(duration: 0.2)) {
                isLifted = false
                scale = 1.0
            }
        }
    }
}
