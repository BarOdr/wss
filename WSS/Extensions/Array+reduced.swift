//
//  Array+reduced.swift
//  WSS
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import Foundation

extension Array {
    func reduced(tolimit limit: Int) -> Self {
        // Ensure the limit is non-negative
        var array = self
        guard limit >= 0 else {
            print("Limit must be non-negative.")
            return array
        }

        // Check if the array exceeds the limit
        if array.count > limit {
            // Calculate how many elements need to be removed
            let numberToRemove = array.count - limit

            // Shuffle the array and remove random elements
            array.shuffle() // This will randomize the order of elements
            array.removeLast(numberToRemove) // Remove elements from the end
        }
        return array
    }
}

extension Array where Element: Hashable {
    var isUnique: Bool {
        var seen = Set<Int>()
        return allSatisfy { seen.insert($0.hashValue).inserted }
    }
}
