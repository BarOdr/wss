//
//  WitcherCardView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 28/07/2024.
//

import SwiftUI

struct WitcherCardView: View {
    var card: WitcherCardModel

    var body: some View {
        Image(card.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
