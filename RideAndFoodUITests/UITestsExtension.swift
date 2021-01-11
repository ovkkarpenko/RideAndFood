//
//  UITestsExtension.swift
//  RideAndFoodUITests
//
//  Created by Oleksandr Karpenko on 11.01.2021.
//  Copyright © 2021 skillbox. All rights reserved.
//

import XCTest

extension XCTestCase {
    func wait(forElement element: XCUIElement, timeout: TimeInterval) {
        let predicate = NSPredicate(format: "exists == 1")

        // This will make the test runner continously evalulate the
        // predicate, and wait until it matches.
        expectation(for: predicate, evaluatedWith: element)
        waitForExpectations(timeout: timeout)
    }
}
