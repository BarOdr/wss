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

    init() {
        let cards = CardsFactory().buildDeck()
        for card in cards {
            print("")
            print(card)
        }
    }

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
