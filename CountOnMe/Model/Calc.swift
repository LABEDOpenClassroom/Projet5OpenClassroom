import Foundation

final class Calc {

    // MARK: - Constants

    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 12
        formatter.locale = Locale.current

        return formatter
    }()

    // MARK: - Properties

    weak var delegate: CalcDisplayDelegate?

    var expression: String = "1 + 1 = 2" {
        didSet {
            delegate?.updateScreen()
        }
    }

    private var elements: [String] {
        expression.split(separator: " ").map { "\($0)" }
    }

    private var expressionIsCorrect: Bool {
        guard let last = elements.last else { return false }

        return !["+", "-", "×", "÷"].contains(last)
    }

    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    private var canAddOperator: Bool {
        guard let last = elements.last else { return false }

        return !["+", "-", "×", "÷"].contains(last)
    }

    private var isFirstElementInExpression: Bool {
        elements.isEmpty
    }

    private var expressionHaveResult: Bool {
        expression.contains("=")
    }

    private var lastResult: Double?

    var error: ErrorTypes?

    // MARK: - Functions

    private func handleError(_ type: ErrorTypes) {
        error = type
        delegate?.displayAlert(type)
    }

    func addNumberToExpression(_ number: String) {
        if expressionHaveResult {
            expression = ""
        }
        
        expression.append(number)
    }

    func clear() {
        if expressionHaveResult {
            expression = ""
            lastResult = nil
        } else if !expression.isEmpty {
            expression.removeLast()

            if expression.last == " " {
                expression.removeLast(1)
            }
        }
    }

    func clearAll() {
        expression = ""
        lastResult = nil
    }

    func addOperatorToExpression(_ operatorText: String) {
        if expressionHaveResult {
            expression = ""
        }

        if isFirstElementInExpression {
            // Si l'expression est vide et l'opérateur est "-", on permet l'ajout du "-"
            if operatorText == "-" {
                expression = "-"
            } else {
                handleError(.incorrectExpression)
            }
        } else if canAddOperator {
            // Si on peut ajouter un opérateur
            expression.append(" \(operatorText) ")
        } else {
            // Si on ne peut pas ajouter d'opérateur (le dernier élément est un opérateur)
            handleError(.existingOperator)
        }
    }

    func resolveExpression() {
        guard expressionIsCorrect else {
            handleError(.incorrectExpression)
            return
        }
        guard expressionHaveEnoughElement else {
            handleError(.haveEnoughElements)
            return
        }
        guard !expressionHaveResult else {
            handleError(.alreadyHaveResult)
            return
        }

        var operations = elements
        let result = performOperations(&operations)

        guard let castedResult = Double(result), let text = Self.numberFormatter.string(from: NSNumber(floatLiteral: castedResult)) else {
            return
        }

        expression.append(" = \(text)")

        lastResult = castedResult
    }

    private func resolveOperation(_ operations: [String], _ index: Int) -> Double? {
        guard let left = Double(operations[index - 1]),
              let right = Double(operations[index + 1]) else { return nil }
        switch operations[index] {
        case "×":
            return left * right
        case "÷":
            return right != 0 ? left / right : nil
        case "+":
            return left + right
        case "-":
            return left - right
        default:
            return nil
        }
    }

    private func reduceOperations(_ ops: [String], priorityOperators: [String]) -> [String] {
        var ops = ops
        var index = 0
        while index < ops.count {
            if priorityOperators.contains(ops[index]) {
                if let result = resolveOperation(ops, index) {
                    ops[index - 1] = "\(result)"
                    ops.removeSubrange(index...index + 1)
                    index -= 1
                } else {
                    handleError(.divisionByZero)
                    return []
                }
            } else {
                index += 1
            }
        }
        return ops
    }

    private func performOperations(_ operations: inout [String]) -> String {
        let priorityOperators = ["×", "÷"]
        let secondaryOperators = ["+", "-"]

        operations = reduceOperations(operations, priorityOperators: priorityOperators)
        if operations.isEmpty { return "" }

        var index = 1
        while index < operations.count {
            if secondaryOperators.contains(operations[index]) {
                if let result = resolveOperation(operations, index) {
                    operations[index - 1] = "\(result)"
                    operations.removeSubrange(index...index + 1)
                    index -= 1
                }
            }
            index += 1
        }

        if let result = Double(operations.first ?? "") {
            if result.truncatingRemainder(dividingBy: 1) == 0 {
                return "\(Int(result))"
            } else {
                return "\(result)"
            }
        } else {
            return ""
        }
    }
}
