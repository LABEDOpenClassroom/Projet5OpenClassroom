//
//  CalcDisplayDelegate.swift
//  CountOnMe
//
//  Created by Toufik LABED .
//

import Foundation

protocol CalcDisplayDelegate: AnyObject {
    func displayAlert(_ error: CalcError)
    func updateScreen()
}
