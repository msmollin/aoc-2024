//
//  main.swift
//  day1
//
//  Created by Smollinger, Matthew (M.) on 12/3/24.
//

import Foundation

guard CommandLine.arguments.count > 1 else {
    print("Please supply file path")
    exit(1)
}

print("Reading location ids...")
guard let data = try? String(contentsOfFile: CommandLine.arguments[1], encoding: .utf8) else {
    print("Failed to read input data")
    exit(1)
}

var list1 = [Int]()
var list2 = [Int]()

data.enumerateLines(invoking: { line, _ in
    let locationIds = line.components(separatedBy: "   ")
    list1.append(Int(locationIds[0])!)
    list2.append(Int(locationIds[1])!)
})

print("Calculating distance...")
let distance = totalDistanceBetweenTwoLists(list1, list2)
print("Distance between lists: \(distance)")

func totalDistanceBetweenTwoLists(_ list1: [Int], _ list2: [Int]) -> Int {
    var total = 0
    let sortedList1 = list1.sorted(by: { $0 < $1 })
    let sortedList2 = list2.sorted(by: { $0 < $1 })
    for (index1, index2) in zip(sortedList1, sortedList2) {
        total += abs(index1 - index2)
    }
    return total
}
