//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Toufik Labed .
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Constants

    private let calc = Calc()

    // MARK: - Properties

    @IBOutlet weak var textView: UITextView!

    // MARK: - Initialisation

    init() {
        super.init(nibName: nil, bundle: nil)

        calc.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    @IBAction
    private func tappedButton(_ sender: UIButton) {
        calc.buttonHasBeenHitten(sender.title(for: .normal))
    }

    @IBAction
    private func allClearButtonTapped() {
        calc.resetExpression()
    }

    @IBAction
    private func equalButtonTapped() {
        calc.resolveExpression()
    }

    private func autoScrollTextView() {
        let range = NSMakeRange(textView.text.count - 1, 0)

        textView.scrollRangeToVisible(range)
    }
}

// MARK: - CalcDisplayDelegate

extension ViewController: CalcDisplayDelegate {

    func updateScreen() {
        textView.text = calc.expression
        autoScrollTextView()
    }

    func displayAlert(_ error: CalcError) {
        let alertVC = UIAlertController(title: error.localizedDescription, message: error.failureReason, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        present(alertVC, animated: true, completion: nil)
    }
}
