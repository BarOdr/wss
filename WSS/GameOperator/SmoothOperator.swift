//
//  SmoothOperator.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import Foundation

final class GameOperator {

    private var decks: BaseDecks

    init(addons: [AddonType], difficulty: Difficulty) {
        self.decks = DecksBuilder(
            cardsFactory: CardsFactory(),
            addons: addons,
            difficultyLevel: difficulty
        ).buildDecks()
    }

    
}
