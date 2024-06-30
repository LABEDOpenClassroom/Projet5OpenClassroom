// Calc.swift
import Foundation

final class Calc {
    
    weak var delegate: CalcDisplayDelegate?
    
    private(set) var expression: String = "1 + 1 = 2" {
        didSet {
            delegate?.updateScreen()
        }
    }
    
    var elements: [String] {
        return expression.split(separator: " ").map { "\($0)" }
    }
    
    var expressionIsCorrect: Bool {
        guard let last = elements.last else { return false }
        return !["+", "-", "×", "÷"].contains(last)
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        guard let last = elements.last else { return false }
        return !["+", "-", "×", "÷"].contains(last)
    }
    
    var isFirstElementInExpression: Bool {
        return elements.isEmpty
    }
    
    var expressionHaveResult: Bool {
        return expression.contains("=")
    }
    
    var lastResult: Double?
    
    var error: ErrorTypes?
    
    func handleError(_ type: ErrorTypes) {
        error = type
        delegate?.displayAlert(type)
    }
    
    func handleInput(_ input: String) {
        if let _ = Double(input) {
            addNumberToExpression(input)
        } else if input == "=" {
            resolveExpression()
        } else if input == "AC" {
            acButtonHasBeenHitten()
        } else if input == "C" {
            cButtonHasBeenHitten()
        } else if ["+", "-", "×", "÷"].contains(input) {
            addOperatorToExpression(input)
        } else {
            handleError(.incorrectExpression)
        }
    }
    
    func setExpression(_ newExpression: String) {
        expression = newExpression
    }
    
    private func addNumberToExpression(_ number: String) {
        if expressionHaveResult {
            expression = ""
        }
        expression.append(number)
    }
    
    private func cButtonHasBeenHitten() {
        if expressionHaveResult {
            expression = ""
            lastResult = nil
        } else if !expression.isEmpty {
            expression.removeLast()
            if expression.last == " " {
                expression.removeLast(2)
            }
        }
    }
    
    private func acButtonHasBeenHitten() {
        expression = ""
        lastResult = nil
    }
    
    private func addOperatorToExpression(_ operatorText: String) {
        if expressionHaveResult {
            expression = ""
        }
        
        if isFirstElementInExpression {
            if operatorText == "-" {
                expression = "-"
            } else {
                handleError(.incorrectExpression)
            }
        } else if canAddOperator {
            expression.append(" \(operatorText) ")
        } else {
            handleError(.existingOperator)
        }
    }
    
    private func resolveExpression() {
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
    
    static var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 12
        formatter.locale = Locale.current
        return formatter
    }()
    
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

