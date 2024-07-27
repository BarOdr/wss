//
//  WitcherCardView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 28/07/2024.
//

import SwiftUI

struct WitcherCardView: View {
    var card: WitcherCardModel
    var singleTapAction: (() -> Void)? = nil
    var doubleTapAction: (() -> Void)? = nil

    var body: some View {
         Image(card.imageName)
             .resizable()
             .aspectRatio(contentMode: .fit)
             .clipShape(RoundedRectangle(cornerRadius: 10))
             .shadow(radius: 10)
             .onTapGesture(count: 2) {
                 doubleTapAction?()
             }
             .simultaneousGesture(
                 TapGesture()
                     .onEnded {
                         singleTapAction?()
                     }
             )
     }
}
