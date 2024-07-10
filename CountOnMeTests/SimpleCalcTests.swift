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
        calc.setExpression("2 + 3")

        // When
        calc.handleInput("=")

        // Then
        XCTAssertEqual(calc.expression, "2 + 3 = 5")
        XCTAssertNil(calc.error)
    }

    func testSimpleSubtraction() {
        // Given
        calc.setExpression("5 - 2")

        // When
        calc.handleInput("=")

        // Then
        XCTAssertEqual(calc.expression, "5 - 2 = 3")
        XCTAssertNil(calc.error)
    }

    func testSimpleMultiplication() {
        // Given
        calc.setExpression("3 × 4")

        // When
        calc.handleInput("=")

        // Then
        XCTAssertEqual(calc.expression, "3 × 4 = 12")
        XCTAssertNil(calc.error)
    }

    func testSimpleDivision() {
        // Given
        calc.setExpression("10 ÷ 2")

        // When
        calc.handleInput("=")

        // Then
        XCTAssertEqual(calc.expression, "10 ÷ 2 = 5")
        XCTAssertNil(calc.error)
    }

    // MARK: - Clear

    func testClearWithResult() {
        // Given
        calc.setExpression("10 ÷ 2")

        // When
        calc.handleInput("=")
        calc.acButtonHasBeenHitten()

        // Then
        XCTAssertEqual(calc.expression, "")
        XCTAssertNil(calc.error)
    }

    func testClearWithNoResult() {
        // Given
        calc.setExpression("10 ÷")

        // When
        calc.cButtonHasBeenHitten() 

        // Then
        XCTAssertEqual(calc.expression, "10")
        XCTAssertNil(calc.error)
    }

    // MARK: - All Clear

    func testAllClear() {
        // Given
        calc.setExpression("10 ÷ 2")

        // When
        calc.acButtonHasBeenHitten()

        // Then
        XCTAssertEqual(calc.expression, "")
        XCTAssertNil(calc.error)
    }

    // MARK: - Complex Operations

    func testComplexExpression() {
        // Given
        calc.setExpression("3 + 5 × 2 - 8 ÷ 4")

        // When
        calc.handleInput("=")

        // Then
        XCTAssertEqual(calc.expression, "3 + 5 × 2 - 8 ÷ 4 = 11")
        XCTAssertNil(calc.error)
    }

    func testComplexExpression2() {
        // Given
        calc.setExpression("1 + 2 - 3 × 4 ÷ 5")

        // When
        calc.handleInput("=")

        // Debug: Affichez l'expression pour vérifier le résultat
        print("Expression après le calcul: \(calc.expression)")
        
        // Then
        XCTAssertTrue(calc.expression.contains("1 + 2 - 3 × 4 ÷ 5 = 0,6"))
        XCTAssertNil(calc.error)
    }

    // MARK: - Error Scenarios

    func testDivisionByZero() {
        // Given
        calc.setExpression("10 ÷ 0")

        // When
        calc.handleInput("=")

        // Then
        XCTAssertEqual(calc.error, .divisionByZero)
    }

    func testIncorrectExpression() {
        // Given
        calc.setExpression("10 +")

        // When
        calc.handleInput("=")

        // Then
        XCTAssertEqual(calc.error, .incorrectExpression)
    }

    func testExistingOperator() {
        // Given
        calc.setExpression("10 +")

        // When
        calc.handleInput("+")

        // Then
        XCTAssertEqual(calc.error, .existingOperator)
    }

    func testMissingElements() {
        // Given
        calc.setExpression("10 +")

        // When
        calc.handleInput("=")

        // Then
        XCTAssertEqual(calc.error, .incorrectExpression)
    }
}

