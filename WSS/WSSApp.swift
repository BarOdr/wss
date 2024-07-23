//
//  WSSApp.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 14/07/2024.
//

import SwiftUI
import SwiftData
import UIKit

@main
struct WSSApp: App {

    let appDependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            GameTabsView()
//            DeckView(viewModel: DeckViewModel(deck: DecksBuilder(cardsFactory: CardsFactory(), addons: [.skellige, .legendaryHunt], difficultyLevel: .easy).buildActionDeck(for: .easy).actionDeck, discarded: []))
        }.environmentObject(appDependencies)
    }
}

final class AppDependencies: ObservableObject {
    let gameOperator: SmoothOperator = SmoothOperator(addons: [], difficulty: .easy)
}
