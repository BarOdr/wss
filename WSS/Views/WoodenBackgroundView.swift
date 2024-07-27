//
//  WoodenBackgroundView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 28/07/2024.
//

import SwiftUI

struct WoodenBackgroundView: View {
    var body: some View {
        Image("wooden_background", bundle: .main)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}
