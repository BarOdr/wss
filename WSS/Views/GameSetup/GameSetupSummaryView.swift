//
//  GameSetupSummaryView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 28/07/2024.
//

import SwiftUI

struct GameSetupSummaryView: View {

    let witcher: Witcher
    let difficulty: Difficulty

    var startGameBlock: (Witcher, Difficulty) -> Void

    var body: some View {
        VStack(spacing: 40) {
            ActionableCardView(imageName: witcher.imageName, size: .big)
                .padding(EdgeInsets(top: 60, leading: 40, bottom: 0, trailing: 40))
                .shadow(radius: 10)
            Text(difficulty.description)
                .foregroundStyle(.white)
                .font(.witcherHeader(size: 20))
            Text("START")
                .foregroundStyle(.white)
                .font(.witcherHeader(size: 30))
                .onTapGesture {
                    print("About to start game with witcher \(witcher.rawValue), difficulty \(difficulty.description)")
                    startGameBlock(witcher, difficulty)
                }
        }
        .padding(EdgeInsets())
    }
}
