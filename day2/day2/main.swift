//
//  main.swift
//  day2
//
//  Created by Smollinger, Matthew (M.) on 12/3/24.
//

import Foundation

guard CommandLine.arguments.count > 1 else {
    print("Please supply file path")
    exit(1)
}

print("Reading fission reports...")
guard let data = try? String(contentsOfFile: CommandLine.arguments[1], encoding: .utf8) else {
    print("Failed to read input data")
    exit(1)
}

var reports = [Report]()
data.enumerateLines(invoking: { line, _ in
    let levels = line.components(separatedBy: " ").map({ Level($0)! })
    reports.append(Report(levels: levels))
})

//print("Number of safe reports: \(reports.filter({$0.isSafe()}).count)\n")

print("Number of safe reports: \(numberOfSafeReports(reports: reports))\n")

// Functionality

typealias Level = Int
class Report {
    let levels: [Level]
    private var dampnedIndex: Int?
    
    init(levels: [Level]) {
        self.levels = levels
    }
    
    func isSafe() -> Bool {
        if levels[0] < levels[1] {
            return testValueMatchesIncreasingSafetyRules(levelIndex: 0)
        } else {
            return testValueMatchesDecreasingSafetyRules(levelIndex: 0)
        }
    }
    
    private func testValueMatchesIncreasingSafetyRules(levelIndex: Int) -> Bool {
        if levelIndex == levels.count - 1 {
            print("Report is safe: \(levels)")
            return true
        }
        
        let currentValue: Int
        if let index = dampnedIndex, index == levelIndex {
            currentValue = levels[levelIndex-1]
        }else {
            currentValue = levels[levelIndex]
        }
        
        let nextValue = levels[levelIndex + 1]
        if currentValue < nextValue &&
            nextValue - currentValue <= 3 {
            return testValueMatchesIncreasingSafetyRules(levelIndex: levelIndex + 1)
        } else if dampnedIndex == nil {
            dampnedIndex = levelIndex + 1
            // The rules state "except if removing a singlxe level from an unsafe report would make it safe",
            // which here should just mean skipping the current check.
            return testValueMatchesIncreasingSafetyRules(levelIndex: dampnedIndex!)
        }
        return false
    }
    
    private func testValueMatchesDecreasingSafetyRules(levelIndex: Int) -> Bool {
        if levelIndex == levels.count - 1 {
            print("Report is safe: \(levels)")
            return true
        }
        
        let currentValue: Int
        if let index = dampnedIndex, index == levelIndex {
            currentValue = levels[levelIndex-1]
        }else {
            currentValue = levels[levelIndex]
        }

        let nextValue = levels[levelIndex + 1]
        if currentValue > nextValue &&
            currentValue - nextValue <= 3 {
            return testValueMatchesDecreasingSafetyRules(levelIndex: levelIndex + 1)
        } else if dampnedIndex == nil {
            dampnedIndex = levelIndex + 1
            // The rules state "except if removing a single level from an unsafe report would make it safe",
            // which here should just mean skipping the current check.
            return testValueMatchesDecreasingSafetyRules(levelIndex: dampnedIndex!)
        }
        return false
    }
}
func numberOfSafeReports(reports: [Report]) -> Int {
    reports.filter({ $0.isSafe() }).count
}
