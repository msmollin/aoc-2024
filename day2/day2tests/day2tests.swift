//
//  day2tests.swift
//  day2tests
//
//  Created by Smollinger, Matthew (M.) on 12/3/24.
//

import Testing

/*
 The unusual data (your puzzle input) consists of many reports, one report per line. Each report is a list of numbers called levels that are separated by spaces. For example:

 7 6 4 2 1
 1 2 7 8 9
 9 7 6 2 1
 1 3 2 4 5
 8 6 4 4 1
 1 3 6 7 9
 This example data contains six reports each containing five levels.
 */


/*
 A report only counts as safe if both of the following are true:

 - The levels are either all increasing or all decreasing.
 - Any two adjacent levels differ by at least one and at most three.
 */

// Test Data
    
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


// Tests

struct day2tests {
    
    @Test func testDescendingReportIsSafe() {
        let report = Report(levels: [7, 6, 4, 2, 1])
        #expect(report.isSafe())
    }
    
    @Test func testAscendingReportIsSafe() {
        let report = Report(levels: [1, 3, 6, 7, 9])
        #expect(report.isSafe())
    }
    
    @Test func testNumberOfSafeReports() {
        let testData: [Report] = .init([
            .init(levels: [7, 6, 4, 2, 1]),
            .init(levels: [1, 2, 7, 8, 9]),
            .init(levels: [9, 7, 6, 2, 1]),
            .init(levels: [1, 3, 2, 4, 5]),
            .init(levels: [8, 6, 4, 4, 1]),
            .init(levels: [1, 3, 6, 7, 9])
        ])
        #expect(numberOfSafeReports(testData) == 2)
    }

}
