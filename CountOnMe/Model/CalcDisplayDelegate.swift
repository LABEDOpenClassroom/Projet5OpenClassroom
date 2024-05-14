//
//  CalcDisplayDelegate.swift
//  CountOnMe
//
//  Created by Toufik LABED on 07/05/2024.
//  Copyright © 2024 Vincent Saluzzo. All rights reserved.
//

import Foundation
protocol CalcDisplayDelegate: AnyObject {
    func displayAlert(_ error: ErrorTypes)
    func updateScreen()
}
