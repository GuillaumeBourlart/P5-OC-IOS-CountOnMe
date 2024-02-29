//
//  File.swift
//  CountOnMe
//
//  Created by Guillaume Bourlart on 31/12/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol CalculatorDelegate: AnyObject{
    func equationDidChange(text: String)
    func errorOccured(error: Calculator.CalculatorError)
}
class Calculator {
    weak var delegate: CalculatorDelegate?
    private var expression: String = ""
    enum CalculatorError: String {
        case cantAddOperator = "Impossible d'ajouter cet operateur"
        case cantAddDot = "You can't add a dot"
        case invalidExpression = "Invalid expression"
        case cantDivideByZero = "You can't devide by zero"}
    
    
    enum Operator: String, CaseIterable {
        case plus = "+"
        case minus = "-"
        case multiply = "*"
        case divide = "/"
        case equal = "="
        var displayValue: String{
            return " \(rawValue) "
        }
    }
    
    private static let dotSign = "."
    
    
    // split elements
    private func splitElements() -> [String]{
        return expression.split(separator: " ").map { "\($0)" }
    }
    
    // check if expression have a result by looking for a "="
    private func expressionHaveResult() -> Bool{
        return splitElements().firstIndex(of: Operator.equal.rawValue) != nil
    }
    
    // Verify that last element is not a "+", "-", "*", "/" or "."
    private func expressionIsCorrect() -> Bool {
        return splitElements().last != Operator.plus.rawValue && splitElements().last != Operator.minus.rawValue && splitElements().last != Operator.multiply.rawValue && splitElements().last != Operator.divide.rawValue
    }
    
    // verify there is at least 3 element in the expression
    private func expressionHaveEnoughElement() -> Bool {
        return splitElements().count >= 3
    }

    func addNumber(number: String){
        guard let _ = Int(number) else {
            
            return
        }
        if expressionHaveResult() {
            resetCalcul()
        }
        expression.append(number)
        delegate?.equationDidChange(text: expression)
    }
    
    // reset the expression
    func resetCalcul(){
        expression = ""
        delegate?.equationDidChange(text: expression)
    }
    
    // verify that operator can be added
    private func canAddOperator() -> Bool {
        return splitElements().last != nil && expressionHaveResult() == false
    }
    
    // add an operator if it can be added
    func addOperator(operatorToAdd: Operator){
        if canAddOperator()  {
            if thereIsntAlreadyOperator() == false{
                removeLast()
            }
            expression.append(operatorToAdd.displayValue)
            delegate?.equationDidChange(text: expression)
        } else {
            delegate?.errorOccured(error: .cantAddOperator)
        }
        
    }
   
    private func thereIsntAlreadyOperator() -> Bool{
        return Operator.allCases.contains { ope in
            return ope.rawValue == splitElements().last
        } == false
    }
    
    private func removeLast(){
        var array = splitElements()
        array.removeLast()
        expression = array.joined(separator: " ")
    }
    
    // verify that Dot can be added
    private func canAddDot() -> Bool {
        return splitElements().last?.contains(Self.dotSign) == false  && splitElements().last != Operator.plus.rawValue && splitElements().last != Operator.minus.rawValue && splitElements().last != Operator.multiply.rawValue && splitElements().last != Operator.divide.rawValue
    }
    // add a Dot if it can be added
    func addDot(){
        if canAddDot()  {
            expression.append(Self.dotSign)
            delegate?.equationDidChange(text: expression)
        } else {
            delegate?.errorOccured(error: .cantAddDot)
        }
        
    }
    
    
    
    //check if it can be divided by zero
    private func dividingByZero(operand: String, number: Double) -> Bool{
        return (operand == Operator.divide.rawValue && number == 0) == false
    }
    
    // calculate final result
    func calculateFinalResult() {
        if canAddOperator() && expressionIsCorrect() && expressionHaveEnoughElement() && expressionHaveResult() == false{
            
            
            // Create local copy of operations
            var operationsToReduce = splitElements()
            
            // Iterate over operations while an operand still here
            while operationsToReduce.count > 1 {
                
                
                var operatorIndex = 1
                //check if there is "*" or "/" and take the first one
                if let fisrtIndexOfMultiplyOrDivide = operationsToReduce.firstIndex(where: {$0 == "*" || $0 == "/"}){
                    operatorIndex = fisrtIndexOfMultiplyOrDivide
                }
                
                
                    
                let left = Double(operationsToReduce[operatorIndex-1])!
                let operand = operationsToReduce[operatorIndex]
                let right = Double(operationsToReduce[operatorIndex+1])!
                
                
                if dividingByZero(operand: operand, number: right) {
                    
                    var resultDouble: Double
                    let resultInt: Int
                    switch operand {
                    case Operator.plus.rawValue: resultDouble = left + right
                    case Operator.minus.rawValue: resultDouble = left - right
                    case Operator.multiply.rawValue: resultDouble = left * right
                    case Operator.divide.rawValue: resultDouble = left / right
                    default: fatalError("Unknown operator !")
                    }
                    
                    //ADDING RESULT AS AN INT OR A DOUBLE DEPENDING OF THE NUMBER
                    let isInteger = floor(resultDouble) == resultDouble
                    if isInteger {
                        resultInt = Int(resultDouble)
                        // Removes the calculation just done and put the result.
                        operationsToReduce.removeSubrange(operatorIndex-1...operatorIndex+1)
                        operationsToReduce.insert("\(resultInt)", at: operatorIndex-1)
                    }
                    else{
                        // Removes the calculation just done and put the result.
                        operationsToReduce.removeSubrange(operatorIndex-1...operatorIndex+1)
                        operationsToReduce.insert("\(resultDouble)", at: operatorIndex-1)
                    }
                    
                    
                    
                }else{
                    delegate?.errorOccured(error: .cantDivideByZero)
                    break
                }
                
            }
            if (operationsToReduce.count == 1){
                // true
                expression.append(" \(Operator.equal.rawValue) \(operationsToReduce[0])")
                delegate?.equationDidChange(text: expression)
            }
        }else{
            delegate?.errorOccured(error: .invalidExpression)
        }
        
    }
    
}
