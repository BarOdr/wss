//
//  RootView.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 14/07/2024.
//

import Foundation

import SwiftUI

struct RootView: View {
    var body: some View {
        ZStack {
            Color.cyan
            Image("witcher_bear", bundle: .main)
        }.ignoresSafeArea()
    }
}
