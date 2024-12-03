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

print("Number of safe reports: \(reports.filter({$0.isSafe()}).count)\n")

// Functionality

typealias Level = Int
struct Report {
    let levels: [Level]
    
    func isSafe() -> Bool {
        if levels[0] < levels[1] {
            return testValueMatchesIncreasingSafetyRules(levelIndex: 1)
        } else {
            return testValueMatchesDecreasingSafetyRules(levelIndex: 1)
        }
    }
    
    private func testValueMatchesIncreasingSafetyRules(levelIndex: Int) -> Bool {
        //Mostly here out of paranoia
        if levelIndex == 0 {
            return testValueMatchesDecreasingSafetyRules(levelIndex: levelIndex + 1)
        }
        let currentValue = levels[levelIndex]
        let previousValue = levels[levelIndex - 1]
        if currentValue > previousValue &&
            currentValue - previousValue <= 3 {
            if levelIndex == levels.count - 1 {
                print("Report is safe: \(levels)")
                return true
            }
            return testValueMatchesIncreasingSafetyRules(levelIndex: levelIndex + 1)
        }
        return false
    }
    
    private func testValueMatchesDecreasingSafetyRules(levelIndex: Int) -> Bool {
        //Mostly here out of paranoia
        if levelIndex == 0 {
            return testValueMatchesDecreasingSafetyRules(levelIndex: levelIndex + 1)
        }
        let currentValue = levels[levelIndex]
        let previousValue = levels[levelIndex - 1]
        if currentValue < previousValue &&
            previousValue - currentValue <= 3 {
            if levelIndex == levels.count - 1 {
                print("Report is safe: \(levels)")
                return true
            }
            return testValueMatchesDecreasingSafetyRules(levelIndex: levelIndex + 1)
        }
        return false
    }
}

func numberOfSafeReports(_ reports: [Report]) -> Int {
    reports.filter({ $0.isSafe() }).count
}
