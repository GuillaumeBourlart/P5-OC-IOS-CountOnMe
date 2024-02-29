//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Guillaume Bourlart on 11/01/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import Calculator
class CountOnMeTests: XCTestCase{
    var expression: String = ""
    var calculatorDelegateState: CalculatorDelegateState = .unknown
    enum CalculatorDelegateState {
        case equationDidChange(text: String)
        case errorOccured(error: Calculator.CalculatorError)
        case unknown
    }
    var app: Calculator! = Calculator()
    
    
    //making CountOnMeTests be delegate target of app
    
    override func setUp() {
        expression = ""
        calculatorDelegateState = .unknown
        app.delegate = self
    }
    
    //------------------------BASIC CALCULS----------------------------
    
    func testGiven1Plus1_WhenEqualIsChoosed_ThenResultisDisplayed()  {
        app.addNumber(number: "1")
        app.addOperator(operatorToAdd: .plus)
        XCTAssertEqual(expression, "1 + ")
        app.addNumber(number: "1")
        XCTAssertEqual(expression, "1 + 1")
        app.calculateFinalResult()
        XCTAssertEqual(expression, "1 + 1 = 2")
    }
    
    func testGiven1Minus1_WhenEqualIsChoosed_ThenResultisDisplayed()  {
        app.addNumber(number: "1")
        app.addOperator(operatorToAdd: .minus)
        XCTAssertEqual(expression, "1 - ")
        app.addNumber(number: "1")
        XCTAssertEqual(expression, "1 - 1")
        app.calculateFinalResult()
        XCTAssertEqual(expression, "1 - 1 = 0")
    }
    
    func testGiven2By2_WhenEqualIsChoosed_ThenResultisDisplayed()  {
        app.addNumber(number: "2")
        app.addOperator(operatorToAdd: .multiply)
        
        XCTAssertEqual(expression, "2 * ")
        app.addNumber(number: "2")
        XCTAssertEqual(expression, "2 * 2")
        app.calculateFinalResult()
        XCTAssertEqual(expression, "2 * 2 = 4")
    }
    
    func testGiven2DividedBy2_WhenEqualIsChoosed_ThenResultisDisplayed()  {
        app.addNumber(number: "2")
        app.addOperator(operatorToAdd: .divide)
        XCTAssertEqual(expression, "2 / ")
        app.addNumber(number: "2")
        XCTAssertEqual(expression, "2 / 2")
        app.calculateFinalResult()
        XCTAssertEqual(expression, "2 / 2 = 1")
    }
    
    
    //CHECK PRIORITY
    func testGiven2Plus9by3_WhenEqualIsChoosed_ThenResultisDisplayed()  {
        app.addNumber(number: "2")
        app.addOperator(operatorToAdd: .plus)
        XCTAssertEqual(expression, "2 + ")
        app.addNumber(number: "9")
        app.addOperator(operatorToAdd: .multiply)
        app.addNumber(number: "3")
        XCTAssertEqual(expression, "2 + 9 * 3")
        app.calculateFinalResult()
        XCTAssertEqual(expression, "2 + 9 * 3 = 29")
    }
    
    func testGiven8DividedBy4by22_WhenEqualIsChoosed_ThenResultisDisplayed()  {
        app.addNumber(number: "8")
        app.addOperator(operatorToAdd: .divide)
        app.addNumber(number: "4")
        app.addOperator(operatorToAdd: .multiply)
        app.addNumber(number: "20")
        app.calculateFinalResult()
        XCTAssertEqual(expression, "8 / 4 * 20 = 40")
    }
    
    func testGiven8By4Devidedby20_WhenEqualIsChoosed_ThenResultisDisplayed()  {
        app.addNumber(number: "8")
        app.addOperator(operatorToAdd: .multiply)
        app.addNumber(number: "4")
        app.addOperator(operatorToAdd: .divide)
        app.addNumber(number: "20")
        app.calculateFinalResult()
        XCTAssertEqual(expression, "8 * 4 / 20 = 1.6")
    }
    
    func testGiven12DividedBy4By8DividedBy10By2_WhenEqualIsChoosed_ThenResultisDisplayed()  {
        app.addNumber(number: "12")
        app.addOperator(operatorToAdd: .divide)
        app.addNumber(number: "4")
        app.addOperator(operatorToAdd: .multiply)
        app.addNumber(number: "8")
        app.addOperator(operatorToAdd: .divide)
        app.addNumber(number: "10")
        app.addOperator(operatorToAdd: .multiply)
        app.addNumber(number: "2")
        app.calculateFinalResult()
        XCTAssertEqual(expression, "12 / 4 * 8 / 10 * 2 = 4.8")
    }
    
    func testGivenAdditionMultiplicationAdditionMultiplication_WhenEqualIsChoosed_ThenResultisDisplayed()  {
        app.addNumber(number: "2")
        app.addOperator(operatorToAdd: .plus)
        app.addNumber(number: "3")
        app.addOperator(operatorToAdd: .multiply)
        app.addNumber(number: "3")
        app.addOperator(operatorToAdd: .plus)
        app.addNumber(number: "4")
        app.addOperator(operatorToAdd: .multiply)
        app.addNumber(number: "2")
        app.calculateFinalResult()
        XCTAssertEqual(expression, "2 + 3 * 3 + 4 * 2 = 19")
    }
    
    func testGivenAdditionMultiplicationAdditionDivision_WhenEqualIsChoosed_ThenResultisDisplayed()  {
        app.addNumber(number: "2")
        app.addOperator(operatorToAdd: .plus)
        app.addNumber(number: "3")
        app.addOperator(operatorToAdd: .multiply)
        app.addNumber(number: "3")
        app.addOperator(operatorToAdd: .plus)
        app.addNumber(number: "4")
        app.addOperator(operatorToAdd: .divide)
        app.addNumber(number: "8")
        app.calculateFinalResult()
        XCTAssertEqual(expression, "2 + 3 * 3 + 4 / 8 = 11.5")
    }
    
    func testGivenAdditionMultiplicationDivisionDivisionAdditionDivision_WhenEqualIsChoosed_ThenResultisDisplayed()  {
        app.addNumber(number: "2")
        app.addOperator(operatorToAdd: .plus)
        app.addNumber(number: "3")
        app.addOperator(operatorToAdd: .multiply)
        app.addNumber(number: "6")
        app.addOperator(operatorToAdd: .divide)
        app.addNumber(number: "4")
        app.addOperator(operatorToAdd: .divide)
        app.addNumber(number: "8")
        app.addOperator(operatorToAdd: .plus)
        app.addNumber(number: "3")
        app.addOperator(operatorToAdd: .divide)
        app.addNumber(number: "6")
        app.calculateFinalResult()
        XCTAssertEqual(expression, "2 + 3 * 6 / 4 / 8 + 3 / 6 = 3.0625")
    }
    
    
    //------------------------LOGIC TEST----------------------------
    
    // CHECK THAT CURRENT OPERATOR IS REPLACED
    func testGiven1Divided_WhenPlusIsChoosed_ThenDivideIsReplacedByPlus()  {
        app.addNumber(number: "1")
        app.addOperator(operatorToAdd: .divide)
        XCTAssertEqual(expression, "1 / ")
        app.addOperator(operatorToAdd: .plus)
        XCTAssertEqual(expression, "1 + ")
    }
    
    // CHECK THAT CURRENT OPERATOR IS REPLACED
    func testGiven1Minus_WhenMinusIsChoosed_ThenMinusIsReplacedByMinus()  {
        app.addNumber(number: "1")
        app.addOperator(operatorToAdd: .minus)
        XCTAssertEqual(expression, "1 - ")
        app.addOperator(operatorToAdd: .minus)
        XCTAssertEqual(expression, "1 - ")
    }
    
    //CHECK THAT DOT IS ADDED
    func testGiven1_WhenDotIsChoosed_ThenDotIsAdded()  {
        app.addNumber(number: "1")
        XCTAssertEqual(expression, "1")
        app.addDot()
        XCTAssertEqual(expression, "1.")
    }
    //CHECK IF DOT IS ADDED WHEN THERE IS ALREADY A DOT
    func testGiven1Dot_WhenDotIsChoosed_ThenDotIsntAdded()  {
        app.addNumber(number: "1")
        XCTAssertEqual(expression, "1")
        app.addDot()
        XCTAssertEqual(expression, "1.")
        app.addDot()
        app.addNumber(number: "5")
        app.addDot()
        XCTAssertEqual(expression, "1.5")
    }
    
    //CHECK IF ONLY NUMBERS CAN BE ADDED
    func testGiven7_WhenTryingToAddLetter_ThenLetterIsntAdded()  {
        app.addNumber(number: "7")
        app.addNumber(number: "L")
        app.addOperator(operatorToAdd: .divide)
        app.addNumber(number: "7")
        XCTAssertEqual(expression, "7 / 7")
    }
    //CHECK IF RESET CALCUL WORKS FINE
    func testGivenExpressionHaveResult_WhenAdding4_Then4IsDisplayed(){
        app.addNumber(number: "6")
        app.addOperator(operatorToAdd: .plus)
        app.addNumber(number: "7")
        app.calculateFinalResult()
        app.addNumber(number: "4")
        XCTAssertEqual(expression, "4")
    }
    
    //------------------------ERROR TEST----------------------------
    
    //CHECK IF OPERATOR CAN BE ADDED IN AN EMPTY EXPRESSION
    func testGivenNothing_WhenPlusIsChoosed_ThenTheresError()  {
        app.resetCalcul()
        app.addOperator(operatorToAdd: .plus)
        expectError(.cantAddOperator)
    }
    //CHECK IF EQUAL BUTTON WORKS FINE
    func testGiven1Plus_WhenEqualIsChoosed_ThenTheresError()  {
        app.addNumber(number: "1")
        app.addOperator(operatorToAdd: .plus)
        app.calculateFinalResult()
        expectError(.invalidExpression)
    }
    
    //CHECK IF EQUAL BUTTON WORKS FINE
    func testGiven2Plus2Equal4_WhenEqualIsChoosed_ThenTheresError()  {
        app.addNumber(number: "2")
        app.addOperator(operatorToAdd: .plus)
        app.addNumber(number: "2")
        app.calculateFinalResult()
        app.calculateFinalResult()
        expectError(.invalidExpression)
    }
    //CHECK IF DOT CAN BE ADDED TWICE IN A NUMBER
    func testGivenLastIsADot_WhenDotIsChoosed_ThenTheresError()  {
        app.addNumber(number: "1")
        app.addDot()
        app.addDot()
        expectError(.cantAddDot)
    }
    
    //CHECK IF ERROR OCCURES WHEN TRYING TO DEVIDE BY ZERO
    func testGivenLastIsADots_WhenDotIsChoosed_ThenTheresError()  {
        app.addOperator(operatorToAdd: .plus)
        expectError(.cantAddOperator)
    }
    
    //CHECK IS DIVISION BY ZERO IS PROSCRIBED
    func testGiven7Dividedby0_WhenEqualisChoosed_ThenTheresError()  {
        app.addNumber(number: "7")
        app.addOperator(operatorToAdd: .divide)
        app.addNumber(number: "0")
        app.calculateFinalResult()
        expectError(.cantDivideByZero)
    }
    
    func expectError(_ expectedError: Calculator.CalculatorError){
        if case let .errorOccured(error: error) = calculatorDelegateState{
            XCTAssertEqual(error, expectedError)
        }else {
            XCTFail()
        }
    }
}

extension CountOnMeTests: CalculatorDelegate {
    //protocol response
    
    func equationDidChange(text: String) {
        expression = text
        calculatorDelegateState = .equationDidChange(text: text)
    }
    
    func errorOccured(error: Calculator.CalculatorError) {
        calculatorDelegateState = .errorOccured(error: error)
    }
}
