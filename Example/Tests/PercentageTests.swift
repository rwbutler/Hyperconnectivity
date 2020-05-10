//
//  PercentageTests.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 09/05/2020.
//  Copyright © 2020 Ross Butler. All rights reserved.
//

import XCTest
@testable import Hyperconnectivity

class PercentageTests: XCTestCase {
    
    func testMidRangeValueApplied() {
        let sut = Percentage(50.0)
        XCTAssertEqual(sut.value, 50.0)
    }
    
    func testLowerBoundaryValueApplied() {
        let sut = Percentage(0.0)
        XCTAssertEqual(sut.value, 0.0)
    }
    
    func testUpperBoundaryValueApplied() {
        let sut = Percentage(100.0)
        XCTAssertEqual(sut.value, 100.0)
    }
    
    func testOutOfLowerBoundValueNotApplied() {
        let sut = Percentage(-0.1)
        XCTAssertEqual(sut.value, 0.0)
    }
    
    func testOutOfUpperBoundValueNotApplied() {
        let sut = Percentage(100.1)
        XCTAssertEqual(sut.value, 100.0)
    }
    
    func testPercentageCalculatedWithMidRangeUIntValues() {
        let sut = Percentage(UInt(2), outOf: UInt(10))
        XCTAssertEqual(sut.value, 20.0)
    }
    
    func testPercentageCalculatedWithLowerBoundaryUIntValues() {
        let sut = Percentage(UInt(0), outOf: UInt(1))
        XCTAssertEqual(sut.value, 0.0)
    }
    
    func testPercentageCalculatedIsZeroWhenDivisorIsZero() {
        let sut = Percentage(UInt(1), outOf: UInt(0))
        XCTAssertEqual(sut.value, 0.0)
    }
    
    func testPercentageNotLessThanSameValue() {
        XCTAssertFalse(Percentage(0.0) < Percentage(0.0))
    }
    
    func testPercentageIsLessThanGreaterValue() {
        XCTAssertTrue(Percentage(0.0) < Percentage(0.1))
    }
    
}
