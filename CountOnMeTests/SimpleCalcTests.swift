// SimpleCalcTests.swift
// SimpleCalcTests
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    
    let calc = Calc()
    
    // MARK: - Simple Operations
    
    func testSimpleAddition() {
        calc.setExpression("2 + 3")
        calc.handleInput("=")
        XCTAssertEqual(calc.expression, "2 + 3 = 5")
        XCTAssertNil(calc.error)
    }
    
    func testSimpleSubtraction() {
        calc.setExpression("5 - 2")
        calc.handleInput("=")
        XCTAssertEqual(calc.expression, "5 - 2 = 3")
        XCTAssertNil(calc.error)
    }
    
    func testSimpleMultiplication() {
        calc.setExpression("3 × 4")
        calc.handleInput("=")
        XCTAssertEqual(calc.expression, "3 × 4 = 12")
        XCTAssertNil(calc.error)
    }
    
    func testSimpleDivision() {
        calc.setExpression("10 ÷ 2")
        calc.handleInput("=")
        XCTAssertEqual(calc.expression, "10 ÷ 2 = 5")
        XCTAssertNil(calc.error)
    }
    
    // MARK: - Complex Operations
    
    func testComplexExpression() {
        calc.setExpression("3 + 5 × 2 - 8 ÷ 4")
        calc.handleInput("=")
        XCTAssertEqual(calc.expression, "3 + 5 × 2 - 8 ÷ 4 = 10")
        XCTAssertNil(calc.error)
    }

    func testComplexExpression2() {
        calc.setExpression("1 + 2 - 3 × 4 ÷ 5")
        calc.handleInput("=")
        XCTAssertTrue(calc.expression.contains("1 + 2 - 3 × 4 ÷ 5 = 0.6"))
        XCTAssertNil(calc.error)
    }

    // MARK: - Error Scenarios
    
    func testDivisionByZero() {
        calc.setExpression("10 ÷ 0")
        calc.handleInput("=")
        XCTAssertEqual(calc.error, .divisionByZero)
    }
    
    func testIncorrectExpression() {
        calc.setExpression("10 +")
        calc.handleInput("=")
        XCTAssertEqual(calc.error, .incorrectExpression)
    }
    
    func testExistingOperator() {
        calc.setExpression("10 +")
        calc.handleInput("+")
        XCTAssertEqual(calc.error, .existingOperator)
    }

    func testMissingElements() {
        calc.setExpression("10 +")
        calc.handleInput("=")
        XCTAssertEqual(calc.error, .haveEnoughElements)
    }
}

