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

@Test func testTotalDistanceBetweenTwoLists() {
    #expect(totalDistanceBetweenTwoLists(list1, list2) == 11)
}
