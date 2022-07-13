//
//  AnotherCalcTests.swift
//  AnotherCalcTests
//
//  Created by Andy Lewis on 7/8/22.
//

import XCTest
@testable import AnotherCalc

class AnotherCalcTests: XCTestCase {
    
    var calculator: AnotherCalc!

    override func setUpWithError() throws {
        try super.setUpWithError()
        calculator = AnotherCalc(recordHistory: true)
    }

    override func tearDownWithError() throws {
        calculator = nil
        try super.tearDownWithError()
    }
    
    func testDividingByZeroDoesNotCrash() {
        
        calculator.addNewDigit(digit: 3)
        calculator.divide()
        calculator.addNewDigit(digit: 0)
        
        XCTAssertFalse(calculator.equals(), "method failed while dividing by zero")
    }
    
    func testSwitchingOperationsDoesNotFail() {
        
        calculator.addNewDigit(digit: 20)
        calculator.plus()
        calculator.minus()
        calculator.times()
        calculator.divide()
        calculator.addNewDigit(digit: 4)
        calculator.equals()
        
        XCTAssertEqual(calculator.primaryReadout, "5.0", "test failed while switching between operations")
    }
    
    func testMultipleDecimalsNotAllowed() {
        
        calculator.addNewDigit(digit: 7)
        calculator.addDecimal()
        calculator.addDecimal()
        calculator.addNewDigit(digit: 6)
        calculator.addDecimal()
        
        XCTAssertEqual(calculator.primaryReadout, "7.6", "multiple decimals detected in primaryReadoutValue")
    }
    
    func testNegativePositiveButton() {
        
        calculator.addNewDigit(digit: 3)
        calculator.addNewDigit(digit: 8)
        calculator.negative()
        calculator.plus()
        calculator.addNewDigit(digit: 5)
        calculator.equals()
        
        XCTAssertEqual(calculator.primaryReadout, "-33.0", "negative button failed")
        
        calculator.clear()
        calculator.negative()
        XCTAssertEqual(calculator.primaryReadout, "-", "negative button failed when value was 0.0")
    }

    func testClearButton(){
        calculator.addNewDigit(digit: 37)
        calculator.clear()
        XCTAssertEqual(calculator.primaryReadout, "0.0", "clear button failed")
    }
    
    func testTip() {
        
        calculator.addNewDigit(digit: 24)
        calculator.addDecimal()
        calculator.addNewDigit(digit: 52)
        calculator.calculateTip(0.1)
        
        XCTAssertEqual(calculator.primaryReadout, "tip = $2.45", "tip calculation failed")
        var secondaryReadoutValue = "$24.52 + $2.45 = $26.97"
        XCTAssertEqual(calculator.secondaryReadout, secondaryReadoutValue, "tip calculation failed")
        
        calculator.backSpace()
        XCTAssertEqual(calculator.primaryReadout, "2.45", "tip calculation failed")
        XCTAssertEqual(calculator.secondaryReadout, "", "tip calculation failed")
        
        calculator.negative()
        calculator.calculateTip(0.1)
        
        XCTAssertFalse(calculator.calculateTip(0.1))
        XCTAssertEqual(calculator.primaryReadout, "-2.45", "tip wasn't properly converted when negative button was pressed")
        
        calculator.negative()
        calculator.calculateTip(0.1)
        XCTAssertEqual(calculator.primaryReadout, "tip = $0.25", "tip wasn't properly converted when negative button was pressed")
        secondaryReadoutValue = "$2.45 + $0.25 = $2.70"
        XCTAssertEqual(calculator.secondaryReadout, secondaryReadoutValue, "tip calculation failed")
        
    }
}
