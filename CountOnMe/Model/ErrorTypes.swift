// ErrorTypes.swift
// CountOnMe
// Created by Toufik LABED

import Foundation
 
enum ErrorTypes {
        case missingButtonTitle
        case existingOperator
        case incorrectExpression
        case haveEnoughElements
        case unknownOperator
        case notNumber
        case firstElementIsAnOperator
        case divisionByZero
        case missingOperator
        case alreadyHaveResult

    /// Alert's title.
    var title: String {
        switch self {
        case .missingOperator: return "Fatal Error"
        case .existingOperator: return "Existing Operator"
        case .incorrectExpression: return "Incorrect Expression"
        case .haveEnoughElements: return "Missing Elements"
        case .unknownOperator: return "Fatal Error"
        case .notNumber: return "Fatal Error"
        case .firstElementIsAnOperator: return "First Element Is an Operator"
        case .divisionByZero: return "Division by Zero"
        case .missingButtonTitle: return "The button title is missing."
        case .alreadyHaveResult: return "New Calculation Needed"
        }
    }

    /// Alert's message.
    var message: String {
        switch self {
        case .missingOperator:
            return "An operator should have been at the end of the expression!"
        case .existingOperator:
            return "An operator is already present!"
        case .incorrectExpression:
            return "Enter a correct expression!"
        case .haveEnoughElements:
            return "Elements are missing to solve the operation!"
        case .unknownOperator:
            return "An unknown operator was found!"
        case .notNumber:
            return "A string element could not be converted to a number!"
        case .firstElementIsAnOperator:
            return "Starting with an operator is not allowed, try starting with '-' for example!"
        case .divisionByZero:
            return "Division by zero is not possible!"
        case .missingButtonTitle:
            return "The button title is missing."
        case .alreadyHaveResult:
            return "Start a new calculation!"
        }
    }
}

