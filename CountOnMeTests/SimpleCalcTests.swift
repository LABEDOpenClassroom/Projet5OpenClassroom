//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//
//
import XCTest
@testable import CountOnMe


class SimpleCalcTests: XCTestCase {
    
    let calc = Calc()
        
        // MARK: - Simple Operations
        
        func testSimpleAddition() {
            calc.expression = "2 + 3"
            calc.buttonHasBeenHitten("=")
            XCTAssert(calc.expression == "2 + 3 = 5")
            XCTAssertNil(calc.error)
        }
        
        func testSimpleSubtraction() {
            calc.expression = "5 - 2"
            calc.buttonHasBeenHitten("=")
            XCTAssert(calc.expression == "5 - 2 = 3")
            XCTAssertNil(calc.error)
        }
        
        func testSimpleMultiplication() {
            calc.expression = "3 × 4"
            calc.buttonHasBeenHitten("=")
            XCTAssert(calc.expression == "3 × 4 = 12")
            XCTAssertNil(calc.error)
        }
        
        func testSimpleDivision() {
            calc.expression = "10 ÷ 2"
            calc.buttonHasBeenHitten("=")
            XCTAssert(calc.expression == "10 ÷ 2 = 5")
            XCTAssertNil(calc.error)
        }
        
        // MARK: - Helpers
        
         func chooseNumberButton() -> String {
            let number = Int.random(in: 1...9)
            return String(number)
        }
        
        private func chooseOperatorButton() -> String {
            let number = Int.random(in: 0...3)
            switch number {
            case 0:
                return "+"
            case 1:
                return "×"
            case 2:
                return "÷"
            default:
                return "-"
            }
        }
    }

/*
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
*/
