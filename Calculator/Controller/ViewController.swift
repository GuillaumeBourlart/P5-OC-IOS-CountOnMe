//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!
    
    @IBOutlet private var operaytionsButtons: [UIButton]!
    private let calculator = Calculator()
    
    
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
        // Do any additional setup after loading the view.
        // Arrondir les coins du textView
           textView.layer.cornerRadius = 10 // Ajustez cette valeur selon l'arrondi désiré
           
           // Arrondir les coins de chaque bouton
           numberButtons.forEach { button in
               button.layer.cornerRadius = 10 // Ajustez cette valeur selon l'arrondi désiré
           }
        
        operaytionsButtons.forEach { button in
            button.layer.cornerRadius = 10 // Ajustez cette valeur selon l'arrondi désiré
        }
    }
    
    
    // View actions
    //Number button is tapped
    @IBAction private func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        calculator.addNumber(number: numberText)
    }
    //Addition button is tapped
    @IBAction private func tappedAdditionButton(_ sender: UIButton) {
        calculator.addOperator(operatorToAdd: .plus)
    }
    //Substraction button is tapped
    @IBAction private func tappedSubstractionButton(_ sender: UIButton) {
        calculator.addOperator(operatorToAdd: .minus)
        
    }
    //Multiplication button is tapped
    @IBAction private func tappedMultiplicationButton(_ sender: UIButton) {
        calculator.addOperator(operatorToAdd: .multiply)
    }
    //Division button is tapped
    @IBAction private func tappedDivisionButton(_ sender: UIButton) {
        calculator.addOperator(operatorToAdd: .divide)
    }
    //Dot button is tapped
    @IBAction private func tappedDotButton(_ sender: UIButton) {
        calculator.addDot()
    }
    //Equal button is tapped
    @IBAction private func tappedEqualButton(_ sender: UIButton) {
        calculator.calculateFinalResult()
    }
    
    //reset button is tapped
    @IBAction private func tappedResetButton(_ sender: UIButton) {
        calculator.resetCalcul()
        
    }
    
    
}
// Delegation that allow calcluator to handle the entire application logic
extension ViewController: CalculatorDelegate{
    func equationDidChange(text: String) {
        self.textView.text = text
    }
    
    func errorOccured(error: Calculator.CalculatorError) {
        let alertVC = UIAlertController(title: "Erreur", message: error.rawValue, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}
