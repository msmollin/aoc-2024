//
//  main.swift
//  day1
//
//  Created by Smollinger, Matthew (M.) on 12/3/24.
//

import Foundation

func totalDistanceBetweenTwoLists(_ list1: [Int], _ list2: [Int]) -> Int {
    var total = 0
    let sortedList1 = list1.sorted(by: { $0 < $1 })
    let sortedList2 = list2.sorted(by: { $0 < $1 })
    for (index1, index2) in zip(sortedList1, sortedList2) {
        total += abs(index1 - index2)
    }
    return total
}
