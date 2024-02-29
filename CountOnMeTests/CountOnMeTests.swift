//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Guillaume Bourlart on 11/01/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe
class CountOnMeTests: XCTestCase{
    var expression: String = ""
    var app: Calulator! = Calulator()
    
    
    //making CountOnMeTests be delegate target of app
    
    override func setUp() {
        expression = ""
        app.delegate = self
        }
        

    //Beginning the tests
    
    
    func testGivenNothing_When1IsChoosed_Then1IsAdded(){
        app.addNumber(number: "1")
        XCTAssertEqual(expression, "1")
    }
    
    func testGiven1_WhenPlusIsChoosed_ThenPlusIsAdded(){
        app.addNumber(number: "1")
        app.addOperator(operatorToAdd: " + ")
        XCTAssertEqual(expression, "1 + ")
    }
        
    func testGiven3_WhenMinusIsChoosed_ThenMinusIsAdded() {
        app.addNumber(number: "3")
        app.addOperator(operatorToAdd: " - ")
        XCTAssertEqual(expression, "3 - ")
    }
    
    func testGiven5_WhenMultiplyIsChoosed_ThenMultiplyIsAdded(){
        app.addNumber(number: "5")
        app.addOperator(operatorToAdd: " * ")
        XCTAssertEqual(expression, "5 * ")
    }
    
    func testGiven7_WhenDivideIsChoosed_ThenDivideIsAdded(){
        app.addNumber(number: "7")
        app.addOperator(operatorToAdd: " / ")
        XCTAssertEqual(expression, "7 / ")
    }
    func testGiven1_WhenDotIsChoosed_ThenDotIsAdded() throws {
        app.addNumber(number: "1")
        app.addDot()
        XCTAssertEqual(expression, "1.")
    }
    
    //====================================================================
    //    MARK: Calculation tests

        
        func testGiven1Plus1_WhenEqualIsChoosed_ThenResultisDisplayed()  {
            app.addNumber(number: "1")
            app.addOperator(operatorToAdd: " + ")
            app.addNumber(number: "1")
            app.calculateFinalResult()
            XCTAssertEqual(expression, "1 + 1 = 2.0")
        }
        
        func testGiven1Minus1_WhenEqualIsChoosed_ThenResultisDisplayed()  {
            app.addNumber(number: "1")
            app.addOperator(operatorToAdd: " - ")
            app.addNumber(number: "1")
            app.calculateFinalResult()
            XCTAssertEqual(expression, "1 - 1 = 0.0")
        }
        
        func testGiven2By2_WhenEqualIsChoosed_ThenResultisDisplayed()  {
            app.addNumber(number: "2")
            app.addOperator(operatorToAdd: " * ")
            app.addNumber(number: "2")
            app.calculateFinalResult()
            XCTAssertEqual(expression, "2 * 2 = 4.0")
        }
        
        func testGiven2Plus9by3_WhenEqualIsChoosed_ThenResultisDisplayed()  {
            app.addNumber(number: "2")
            app.addOperator(operatorToAdd: " + ")
            app.addNumber(number: "9")
            app.addOperator(operatorToAdd: " * ")
            app.addNumber(number: "3")
            app.calculateFinalResult()
            XCTAssertEqual(expression, "2 + 9 * 3 = 29.0")
        }
        
        func testGiven2DividedBy2_WhenEqualIsChoosed_ThenResultisDisplayed()  {
            app.addNumber(number: "2")
            app.addOperator(operatorToAdd: " / ")
            app.addNumber(number: "2")
            app.calculateFinalResult()
            XCTAssertEqual(expression, "2 / 2 = 1.0")
        }
        
        func testGiven8DividedBy4by22_WhenEqualIsChoosed_ThenResultisDisplayed()  {
            app.addNumber(number: "8")
            app.addOperator(operatorToAdd: " / ")
            app.addNumber(number: "4")
            app.addOperator(operatorToAdd: " * ")
            app.addNumber(number: "20")
            app.calculateFinalResult()
            XCTAssertEqual(expression, "8 / 4 * 20 = 40.0")
        }
    
    func testGiven8By4Devidedby22_WhenEqualIsChoosed_ThenResultisDisplayed()  {
        app.addNumber(number: "8")
        app.addOperator(operatorToAdd: " * ")
        app.addNumber(number: "4")
        app.addOperator(operatorToAdd: " / ")
        app.addNumber(number: "20")
        app.calculateFinalResult()
        XCTAssertEqual(expression, "8 * 4 / 20 = 1.6")
    }
    func testGiven12DividedBy4By8DividedBy10By2_WhenEqualIsChoosed_ThenResultisDisplayed()  {
        
        app.addNumber(number: "12")
        app.addOperator(operatorToAdd: " / ")
        app.addNumber(number: "4")
        app.addOperator(operatorToAdd: " * ")
        app.addNumber(number: "8")
        app.addOperator(operatorToAdd: " / ")
        app.addNumber(number: "10")
        app.addOperator(operatorToAdd: " * ")
        app.addNumber(number: "2")
        app.calculateFinalResult()
            XCTAssertEqual(expression, "12 / 4 * 8 / 10 * 2 = 4.8")
        }
    
    
        func testGiven3Plus4Equal7_When7IsChoosed_ThenTheCalculIsResetAndNowDsiplay7() {
            expression = "3 + 4 = 7"
            app.addNumber(number: "3")
            app.addOperator(operatorToAdd: " + ")
            app.addNumber(number: "4")
            app.calculateFinalResult()
            app.addNumber(number: "7")
            XCTAssertEqual(expression, "7")
        }
  
    //   error test
        
        func testGivenNothing_WhenPlusIsChoosed_ThenTheresError() throws {
            app.resetCalcul()
            app.addOperator(operatorToAdd: " + ")
            
            XCTAssertEqual(expression, "error")
        }
        
        func testGiven1Plus_WhenPlusIsChoosed_ThenTheresError() throws {
            app.addNumber(number: "1")
            app.addOperator(operatorToAdd: " + ")
            app.addOperator(operatorToAdd: " + ")
            XCTAssertEqual(expression, "error")
        }
        
        func testGiven1Minus_WhenMinusIsChoosed_ThenTheresError() throws {
            app.addNumber(number: "1")
            app.addOperator(operatorToAdd: " - ")
            app.addOperator(operatorToAdd: " - ")
            XCTAssertEqual(expression, "error")
        }
        
        
        

        func testGiven1Plus_WhenEqualIsChoosed_ThenTheresError() throws {
            app.addNumber(number: "1")
            app.addOperator(operatorToAdd: " + ")
            app.calculateFinalResult()
            XCTAssertEqual(expression, "error")
        }
        
        func testGiven1_WhenTheEqualIsChoosed_ThenTheresError() throws {
            app.addNumber(number: "1")
            app.calculateFinalResult()
            XCTAssertEqual(expression, "error")
        }
        
        func testGiven2Plus2Equal4_WhenEqualIsChoosed_ThenTheresError() throws {
            app.addNumber(number: "2")
            app.addOperator(operatorToAdd: " + ")
            app.addNumber(number: "2")
            app.calculateFinalResult()
            app.calculateFinalResult()
            XCTAssertEqual(expression, "error")
        }
        
    func testGivenLastIsADot_WhenDotIsChoosed_ThenTheresError() throws {
        app.addNumber(number: "1")
        app.addDot()
        app.addDot()
        XCTAssertEqual(expression, "error")
    }
    func testGivenLastIsADots_WhenDotIsChoosed_ThenTheresError() throws {
        app.addOperator(operatorToAdd: " + ")
        XCTAssertEqual(expression, "error")
    }
       
    func testGivenDivided_When0IsChoosed_ThenTheresError() throws {
        app.addNumber(number: "2")
        app.addOperator(operatorToAdd: " / ")
        app.addNumber(number: "0")
        XCTAssertEqual(expression, "error")
    }
    
}


extension CountOnMeTests: CalculatorDelegate {
    //protocol response
       
    func equationDidChange(text: String) {
        expression = text
    }

    func errorOccured() {
        expression = "error"
    }
    }
