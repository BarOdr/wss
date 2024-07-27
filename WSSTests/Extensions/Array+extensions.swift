//
//  Array+isUnique.swift
//  WSSTests
//
//  Created by Bartek Odrzywolek on 20/07/2024.
//

import Foundation

extension Array where Element: Hashable {

    static func compareArrays<T: Hashable>(_ array1: [T], _ array2: [T]) -> (areIdentical: Bool, onlyInArray2: [T]?, onlyInArray1: [T]?) {
        // Check if the arrays are identical by comparing their contents
        let areIdentical = array1 == array2

        // Create sets from the arrays to perform set operations
        let set1 = Set(array1)
        let set2 = Set(array2)

        // Find elements in array2 that are not in array1
        let onlyInArray2Set = set2.subtracting(set1)
        // Find elements in array1 that are not in array2
        let onlyInArray1Set = set1.subtracting(set2)

        // Convert sets to arrays and handle empty sets by returning nil
        let onlyInArray2Result = onlyInArray2Set.isEmpty ? nil : Array<T>(onlyInArray2Set)
        let onlyInArray1Result = onlyInArray1Set.isEmpty ? nil : Array<T>(onlyInArray1Set)

        // Return the results as a tuple
        return (areIdentical, onlyInArray2Result, onlyInArray1Result)
    }
}
