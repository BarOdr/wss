//
//  WSSApp.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 14/07/2024.
//

import SwiftUI
import SwiftData

@main
struct WSSApp: App {

    var body: some Scene {
        WindowGroup {
            CardsShowcaseView(
                viewModel: CardsShowcaseViewModel(
                    factory: CardsFactory()
                )
            )
        }
    }
}
