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
            ChooseWitcherView()
//            GameTabsView(
//                viewModel: GameTabsViewModel(
//                    decks: DecksBuilder(
//                        cardsFactory: CardsFactory(),
//                        addons: [
//                            .legendaryHunt,
//                            .skellige
//                        ],
//                        difficultyLevel: .medium,
//                        witcher: .ciri
//                    ).buildDecks()
//                )
//            )
        }.environmentObject(appDependencies)
    }
}

final class AppDependencies: ObservableObject {
    let gameOperator: SmoothOperator = SmoothOperator(
        configuration: GameConfiguration(
            witcher: .ciri,
            addons: [
                .legendaryHunt,
                .skellige
            ],
            difficulty: .medium
        )
    )
}
