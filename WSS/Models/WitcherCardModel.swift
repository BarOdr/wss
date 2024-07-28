//
//  WitcherCardModel.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 28/07/2024.
//

import Foundation

struct WitcherCardModel: Identifiable, Equatable {
    var id: String {
        "id_\(witcher.rawValue)"
    }
    var witcher: Witcher
}
