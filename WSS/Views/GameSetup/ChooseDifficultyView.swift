//
//  ChooseDifficultyView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 28/07/2024.
//

import SwiftUI

struct ChooseDifficultyView: View {

    var difficultyChosenBlock: (Difficulty) -> Void

    var levels: [Difficulty] {
        Difficulty.allCases
    }
    var body: some View {
        VStack(spacing: 20) {
            ForEach(levels) { level in
                Button(action: {
                    difficultyChosenBlock(level)
                }, label: {
                    Text(level.description)
                        .font(.witcherHeader(size: 30))
                        .foregroundStyle(.white)
                })
            }
        }
    }
}
