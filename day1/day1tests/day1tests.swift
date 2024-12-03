//
//  day1tests.swift
//  day1tests
//
//  Created by Smollinger, Matthew (M.) on 12/3/24.
//

import Testing

// Sample Data
/*
 3   4
 4   3
 2   5
 1   3
 3   9
 3   3
 */

let list1 = [
    3,
    4,
    2,
    1,
    3,
    3,
]

let list2 = [
    4,
    3,
    5,
    3,
    9,
    3,
]


func totalDistanceBetweenTwoLists(_ list1: [Int], _ list2: [Int]) -> Int {
    var total = 0
    let sortedList1 = list1.sorted(by: { $0 < $1 })
    let sortedList2 = list2.sorted(by: { $0 < $1 })
    for (index1, index2) in zip(sortedList1, sortedList2) {
        total += abs(index1 - index2)
    }
    return total
}

@Test func testTotalDistanceBetweenTwoLists() {
    #expect(totalDistanceBetweenTwoLists(list1, list2) == 11)
}
