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

// Tests

struct day2tests {
    // This is duplicated from, and shadows, the main.swift free function because
    // for some reason this function signature causes a SIL generation crash
    // on Xcode 16.1 when running on MacOS 15.2 beta3.
    func numberOfSafeReports(reports: [Report]) -> Int {
        reports.filter({ $0.isSafe() }).count
    }

    
    let testData: [Report] = [
        Report(levels: [7, 6, 4, 2, 1]),
        Report(levels: [1, 2, 7, 8, 9]),
        Report(levels: [9, 7, 6, 2, 1]),
        Report(levels: [1, 3, 2, 4, 5]),
        Report(levels: [8, 6, 4, 4, 1]),
        Report(levels: [1, 3, 6, 7, 9])
    ]
    
    @Test func testNumberOfSafeReports() {
        #expect(numberOfSafeReports(reports: testData) == 4)
    }
    
    @Test func testDescendingReportIsSafe() {
        let report = Report(levels: [7, 6, 4, 2, 1])
        #expect(report.isSafe())
    }
    
    @Test func testAscendingReportIsSafe() {
        let report = Report(levels: [1, 3, 6, 7, 9])
        #expect(report.isSafe())
    }
    
    @Test func testAlwaysFailingIncreasingTest() {
        let report = Report(levels: [1, 2, 7, 8, 9])
        #expect(!report.isSafe())
    }
    
    @Test func testAlwaysFailingDecreasingTest() {
        let report2 = Report(levels: [9, 7, 6, 2, 1])
        #expect(!report2.isSafe())
    }
    
    @Test func testDuplicationHandling() {
        let report = Report(levels: [8, 6, 4, 4, 1])
        #expect(report.isSafe())

    }
    
}
