//
//  Item.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 14/07/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
