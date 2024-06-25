//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Toufik Labed .
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Constants

    private let calc = Calc()

    // MARK: - Properties

    @IBOutlet weak var textView: UITextView!
    @IBOutlet private weak var acButton: UIButton!
    @IBOutlet private weak var cButton: UIButton!

    // MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        calc.delegate = self
    }

    private func autoScrollTextView() {
        let range = NSMakeRange(textView.text.count - 1, 0)

        textView.scrollRangeToVisible(range)
    }

    private func changeCACButtons(isEnabled: Bool, backgroundColor: UIColor) {
        let buttons: [UIButton] = [cButton, acButton]

        for button in buttons {
            button.isEnabled = isEnabled
            button.backgroundColor = backgroundColor
        }
    }

    @IBAction private func hasTappedOnNumber(_ sender: UIButton) {
        calc.addNumberToExpression("\(sender.tag)")
    }

    @IBAction private func hasTappedOnOperator(_ sender: UIButton) {
        let tag = sender.tag

        let newOperator: String
        switch tag {
        case 1000:
            newOperator = "+"
        case 1001:
            newOperator = "-"
        case 1002:
            newOperator = "×"
        case 1003:
            newOperator = "÷"

        default:
            return
        }

        calc.addOperatorToExpression(newOperator)
    }

    @IBAction private func hasTappedOnEqual(_ sender: UIButton) {
        calc.resolveExpression()
    }

    @IBAction private func hasTappedOnAllClear(_ sender: UIButton) {
        calc.clearAll()
    }

    @IBAction private func hasTappedOnClear(_ sender: UIButton) {
        calc.clear()
    }
}

// MARK: - CalcDisplayDelegate

extension ViewController: CalcDisplayDelegate {

    func updateScreen() {
        textView.text = calc.expression

        autoScrollTextView()
    }

    func displayAlert(_ error: ErrorTypes) {
        let alertVC = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)

        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        present(alertVC, animated: true, completion: nil)
    }
}
