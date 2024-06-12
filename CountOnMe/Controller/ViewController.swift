//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Toufik Labed .
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet private weak var acButton: UIButton!
    @IBOutlet private weak var cButton: UIButton!
    
     let calc = Calc()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calc.delegate = self
        
    }
    
    
    @IBAction private func tappedButton(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
                calc.handleInput(title)
            }
        
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
}

extension ViewController: CalcDisplayDelegate {
    func updateScreen() {
            textView.text = calc.expression
            autoScrollTextView()
        }
    
    
    
    func displayAlert(_ error: ErrorTypes) {
        let alertVC = UIAlertController(title: error.title,
                                        message: error.message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    }
    
    
    
    
    
  
    




    
