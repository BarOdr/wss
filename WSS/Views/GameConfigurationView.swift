//
//  GameConfigurationView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 28/07/2024.
//

import SwiftUI

struct GameConfigurationView: View {
    var body: some View {
        ZStack {
            WoodenBackgroundView()
        }
    }

    var chooseWitcherView: some View {
        ScrollableGridView()
    }
}
