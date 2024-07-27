//
//  RemainingCardsView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 27/07/2024.
//

import SwiftUI

struct RemainingCardsCountView: View {
    let remainingCount: Int
    let initialCount: Int
    var body: some View {
        Text("\(String(remainingCount))/\(String(initialCount))")
            .font(.witcherTextRegular(size: 20))
            .foregroundStyle(.white)
            .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
    }
}
