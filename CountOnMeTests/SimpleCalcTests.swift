//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//

import XCTest
@testable import CountOnMe


class SimpleCalcTests: XCTestCase {
    
    let calc = Calc()
    
    // MARK: - Simple Operations
    
    func testSimpleAddition() {
        calc.expression = "2 + 3"
        calc.handleInput("=")
        XCTAssert(calc.expression == "2 + 3 = 5")
        XCTAssertNil(calc.error)
    }
    
    func testSimpleSubtraction() {
        calc.expression = "5 - 2"
        calc.handleInput("=")
        XCTAssert(calc.expression == "5 - 2 = 3")
        XCTAssertNil(calc.error)
    }
    
    func testSimpleMultiplication() {
        calc.expression = "3 × 4"
        calc.handleInput("=")
        XCTAssert(calc.expression == "3 × 4 = 12")
        XCTAssertNil(calc.error)
    }
    
    func testSimpleDivision() {
        calc.expression = "10 ÷ 2"
        calc.handleInput("=")
        XCTAssert(calc.expression == "10 ÷ 2 = 5")
        XCTAssertNil(calc.error)
    }
    
    // MARK: - Complex Operations
    
    func testComplexExpression() {
        calc.expression = "3 + 5 × 2 - 8 ÷ 4"
        calc.handleInput("=")

        XCTAssert(calc.expression == "3 + 5 × 2 - 8 ÷ 4 = 11")
        XCTAssertNil(calc.error)
    }

    func testComplexExpression2() {
        calc.expression = "1 + 2 - 3 × 4 ÷ 5"
        calc.handleInput("=")

        XCTAssertTrue(calc.expression.contains("1 + 2 - 3 × 4 ÷ 5 = 0,6"))
        XCTAssertNil(calc.error)
    }

    // MARK: - Error Scenarios
    
    func testDivisionByZero() {
        calc.expression = "10 ÷ 0"
        calc.handleInput("=")
        XCTAssert(calc.error == .divisionByZero)
    }
    
    func testIncorrectExpression() {
        calc.expression = "10 +"
        calc.handleInput("=")
        XCTAssert(calc.error == .incorrectExpression)
    }
    /*
    func testExistingOperator() {
        calc.expression = "10 + +"
        calc.handleInput("=")

        XCTAssertEqual(calc.error, .existingOperator)
    }
    */
    
    func testExistingOperator() {
        calc.expression = "10 +"
        calc.handleInput("+")        
        XCTAssertEqual(calc.error, .existingOperator)
    }

    func testMissingElements() {
        calc.expression = "10 +"
        calc.handleInput("=")
        XCTAssert(calc.error == .incorrectExpression)
    }
}

