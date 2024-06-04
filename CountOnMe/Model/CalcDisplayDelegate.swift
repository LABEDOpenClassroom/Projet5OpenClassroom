//
//  CalcDisplayDelegate.swift
//  CountOnMe
//
//  Created by Toufik LABED .
//

import Foundation

protocol CalcDisplayDelegate: AnyObject {
    func displayAlert(_ error: ErrorTypes)
    func updateScreen()
}
