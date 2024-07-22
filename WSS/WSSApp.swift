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

    let appDependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            ActionDeckView(viewModel: ActionDeckViewModel(deck: DecksBuilder(cardsFactory: CardsFactory(), addons: [.skellige, .legendaryHunt], difficultyLevel: .easy).buildActionDeck(for: .easy).actionDeck, discarded: []))
        }.environmentObject(appDependencies)
    }
}

final class AppDependencies: ObservableObject {
    let gameOperator: GameOperator = GameOperator(addons: [], difficulty: .easy)
}
