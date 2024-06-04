import Foundation

final class Calc {
    
    weak var delegate: CalcDisplayDelegate?
    
    var expression: String = "1 + 1 = 2" {
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
    
    func buttonHasBeenHitten(_ title: String?) {
        guard let title = title, !title.isEmpty else {
            handleError(.missingButtonTitle)
            return
        }
        if let _ = Double(title) {
            addNumberToExpression(title)
        } else if title == "=" {
            resolveExpression()
        } else if title == "AC" {
            acButtonHasBeenHitten()
        } else if title == "C" {
            cButtonHasBeenHitten()
        } else {
            addOperatorToExpression(title)
        }
    }
    
    func addNumberToExpression(_ number: String) {
        if expressionHaveResult {
            expression = ""
        }
        expression.append(number)
    }
    
    func cButtonHasBeenHitten() {
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
    
    func acButtonHasBeenHitten() {
        expression = ""
        lastResult = nil
    }
    
    func addOperatorToExpression(_ operatorText: String) {
        if expressionHaveResult {
            expression = ""
        }
        if canAddOperator && !isFirstElementInExpression {
            expression.append(" \(operatorText) ")
        } else if operatorText == "-" && isFirstElementInExpression {
            expression = "-"
        } else {
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
        expression.append(" = \(result)")
        lastResult = Double(result)
    }
    
    func performOperations(_ operations: inout [String]) -> String {
        let priorityOperators = ["×", "÷"]
        let secondaryOperators = ["+", "-"]
        
        func resolveOperation(_ index: Int) -> Double? {
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
        
        func reduceOperations(_ ops: [String]) -> [String] {
            var ops = ops
            var index = 0
            while index < ops.count {
                if priorityOperators.contains(ops[index]) {
                    if let result = resolveOperation(index) {
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
        
        operations = reduceOperations(operations)
        if operations.isEmpty { return "" }
        
        var index = 1
        while index < operations.count {
            if secondaryOperators.contains(operations[index]) {
                if let result = resolveOperation(index) {
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


