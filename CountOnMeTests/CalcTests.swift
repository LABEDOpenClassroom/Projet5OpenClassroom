import XCTest
@testable import CountOnMe

final class CalcTests: XCTestCase {

    // MARK: - Constants

    private var calc: Calc!

    // MARK: - Functions

    override func setUp() {
        calc = Calc()
    }

    // MARK: - Simple Operations

    func testSimpleAddition() {
        // Given
        calc.addNumberToExpression("2")
        calc.addOperatorToExpression("+")
        calc.addNumberToExpression("3")

        // When
        calc.resolveExpression()

        // Then
        XCTAssert(calc.expression == "2 + 3 = 5")
        XCTAssertNil(calc.error)
    }

    func testSimpleSubtraction() {
        // Given
        calc.addNumberToExpression("5")
        calc.addOperatorToExpression("-")
        calc.addNumberToExpression("2")

        // When
        calc.resolveExpression()

        // Then
        XCTAssert(calc.expression == "5 - 2 = 3")
        XCTAssertNil(calc.error)
    }

    func testSimpleMultiplication() {
        // Given
        calc.addNumberToExpression("3")
        calc.addOperatorToExpression("×")
        calc.addNumberToExpression("4")
        
        // When
        calc.resolveExpression()

        // Then
        XCTAssert(calc.expression == "3 × 4 = 12")
        XCTAssertNil(calc.error)
    }

    func testSimpleDivision() {
        // Given
        calc.addNumberToExpression("10")
        calc.addOperatorToExpression("÷")
        calc.addNumberToExpression("2")
        
        // When
        calc.resolveExpression()

        // Then
        XCTAssert(calc.expression == "10 ÷ 2 = 5")
        XCTAssertNil(calc.error)
    }

    // MARK: - Clear

    func testClearWithResult() {
        // Given
        calc.expression = "10 ÷ 2"

        // When
        calc.resolveExpression()
        calc.clear()

        // Then
        XCTAssertEqual(calc.expression, "")
        XCTAssertNil(calc.error)
    }

    func testClearWithNoResult() {
        // Given
        calc.expression = "10 ÷"

        // When
        calc.clear()

        // Then
        XCTAssertEqual(calc.expression, "10")
        XCTAssertNil(calc.error)
    }

    // MARK: - All Clear

    func testAllClearWith() {
        // Given
        calc.expression = "10 ÷ 2"

        // When
        calc.clearAll()

        // Then
        XCTAssertEqual(calc.expression, "")
        XCTAssertNil(calc.error)
    }

    // MARK: - Complex Operations

    func testComplexExpression() {
        // Given
        calc.expression = "3 + 5 × 2 - 8 ÷ 4"
        
        // When
        calc.resolveExpression()

        // Then
        XCTAssert(calc.expression == "3 + 5 × 2 - 8 ÷ 4 = 11")
        XCTAssertNil(calc.error)
    }

    func testComplexExpression2() {
        // Given
        calc.expression = "1 + 2 - 3 × 4 ÷ 5"
        
        // When
        calc.resolveExpression()

        // Then
        XCTAssertTrue(calc.expression.contains("1 + 2 - 3 × 4 ÷ 5 = 0,6"))
        XCTAssertNil(calc.error)
    }

    // MARK: - Error Scenarios

    func testDivisionByZero() {
        // Given
        calc.expression = "10 ÷ 0"
        
        // When
        calc.resolveExpression()

        // Then
        XCTAssert(calc.error == .divisionByZero)
    }

    func testIncorrectExpression() {
        // Given
        calc.expression = "10 +"
        
        // When
        calc.resolveExpression()

        // Then
        XCTAssert(calc.error == .incorrectExpression)
    }

    func testExistingOperator() {
        // Given
        calc.expression = "10 +"

        // When
        calc.addOperatorToExpression("+")

        // Then
        XCTAssertEqual(calc.error, .existingOperator)
    }

    func testMissingElements() {
        // Given
        calc.expression = "10 +"
        
        // When
        calc.resolveExpression()

        // Then
        XCTAssert(calc.error == .incorrectExpression)
    }
}
