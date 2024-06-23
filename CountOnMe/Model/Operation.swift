//
//  Operation.swift
//  CountOnMe
//
//  Created by Toufik LABED 
//

import Foundation
enum Operation {
    case addition, substraction, division, multiplication
    
    static func determination(_ operatorText: String) -> Operation? {
        switch operatorText {
        case "+":
            return .addition
        case "-":
            return .substraction
        case "×":
            return .multiplication
        case "÷":
            return .division
        default:
            return nil
        }
    }
    
    func resolve(_ left: Double, _ right: Double) -> String? {
        switch self {
        case .addition:
            return String(left + right)
        case .substraction:
            return String(left - right)
        case .multiplication:
            return String(left * right)
        case .division:
            if right != 0 {
                return String(left / right)
            } else {
                return nil
            }
        }
    }
    
}


