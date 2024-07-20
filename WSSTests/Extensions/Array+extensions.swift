//
//  Array+isUnique.swift
//  WSSTests
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import Foundation

extension Array where Element: Hashable {
    var isUnique: Bool {
        var seen = Set<Int>()
        return allSatisfy { seen.insert($0.hashValue).inserted }
    }
}
