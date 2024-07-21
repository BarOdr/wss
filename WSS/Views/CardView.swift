//
//  CardView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import SwiftUI

struct CardView: View {

    @ObservedObject var model: ActionCardModel

    var body: some View {
        Image(model.imageName, bundle: .main)
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .aspectRatio(contentMode: .fit)
            .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
    }
}

#Preview {
    CardView(model: CardsFactory().previewModel())
}
