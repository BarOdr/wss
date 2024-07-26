//
//  SmoothOperator.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import Foundation

struct GameConfiguration {
    let witcher: Witcher
    let addons: [AddonType]
    let difficulty: Difficulty
}

final class SmoothOperator: ObservableObject {

    @Published var decks: BaseDecks

    init(configuration: GameConfiguration) {
        self.decks = DecksBuilder(
            cardsFactory: CardsFactory(),
            addons: configuration.addons,
            difficultyLevel: configuration.difficulty,
            witcher: configuration.witcher
        ).buildDecks()
    }
}
