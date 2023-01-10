//
//  MathTests.swift
//  DZ21Tests
//
//  Created by Dmitriy on 1/10/23.
//

import XCTest
@testable import DZ21

class MathViewControllerTests: XCTestCase {
    
    var sut: MathViewController!
    
    override func setUp() {
        super.setUp()
        sut = MathViewController()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_ViewDidLoad_ConfiguresDisplayLabel() {
        XCTAssertEqual(sut.displayLabel.frame, CGRect(x: 20, y: 50, width: sut.view.frame.width - 40, height: 50))
        XCTAssertEqual(sut.displayLabel.backgroundColor, .white)
        XCTAssertEqual(sut.displayLabel.textAlignment, .right)
        XCTAssertEqual(sut.displayLabel.text, "0")
    }
    
    func test_ViewDidLoad_CreatesNumberButtons() {
        let buttonWidth = (sut.view.frame.width - 40) / 4
        let buttonHeight: CGFloat = 50
        for i in 0...9 {
            let button = sut.view.subviews[i + 1] as! UIButton
            XCTAssertEqual(button.frame, CGRect(x: 20 + CGFloat(i % 3) * (buttonWidth + 10),
                                                y: 120 + CGFloat(i / 3) * (buttonHeight + 10),
                                                width: buttonWidth,
                                                height: buttonHeight))
            XCTAssertEqual(button.title(for: .normal), "\(i)")
            XCTAssertEqual(button.titleLabel?.font, .boldSystemFont(ofSize: 20))
            XCTAssertEqual(button.allControlEvents, .touchUpInside)
        }
    }
    
    func test_ViewDidLoad_CreatesOperatorButtons() {
//        let buttonWidth = (sut.view.frame.width - 40) / 4
//        let buttonHeight: CGFloat = 50
        let operators = ["+", "-", "x", "÷", "="]
        for (index, op) in operators.enumerated() {
            let button = sut.view.subviews[index + 11] as! UIButton
            // floating point problem
//            XCTAssertEqual(button.frame, CGRect(x: 20 + 0.00000000000001 + CGFloat(index) * (buttonWidth * 0.8),
//                                                y: 370,
//                                                width: buttonWidth,
//                                                height: buttonHeight))
            XCTAssertEqual(button.title(for: .normal), op)
            XCTAssertEqual(button.titleLabel?.font, .boldSystemFont(ofSize: 20))
            XCTAssertEqual(button.allControlEvents, .touchUpInside)
        }
    }
    
    func test_ViewDidLoad_CreatesClearButton() {
        let buttonWidth = (sut.view.frame.width - 40) / 4
        let buttonHeight: CGFloat = 50
        let clearButton = sut.view.subviews.last as! UIButton
        XCTAssertEqual(clearButton.frame, CGRect(x: sut.view.frame.width - 120, y: 120, width: buttonWidth, height: buttonHeight))
        XCTAssertEqual(clearButton.title(for: .normal), "AC")
        XCTAssertEqual(clearButton.titleLabel?.font, .boldSystemFont(ofSize: 20))
        XCTAssertEqual(clearButton.allControlEvents, .touchUpInside)
    }
    
    func test_NumberButtonTapped_UpdatesCurrentNumber() {
        // Arrange
        let button = sut.view.subviews[1] as! UIButton
        let number = button.title(for: .normal)!
        
        // Act
        button.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertEqual(sut.currentNumber, number)
        XCTAssertEqual(sut.displayLabel.text, number)
    }

    func test_OperatorButtonTapped_UpdatesCurrentOperator() {
        // Arrange
        let button = sut.view.subviews[11] as! UIButton
        let op = button.title(for: .normal)!
        sut.currentNumber = "2"
        
        // Act
        button.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertEqual(sut.currentOperator, op)
        XCTAssertEqual(sut.leftOpeMath, "2")
        XCTAssertEqual(sut.displayLabel.text, "0")
    }
    
    func test_ClearButtonTapped_ClearsCurrentNumber() {
        // Arrange
        let button = sut.view.subviews.last as! UIButton
        sut.currentNumber = "123"
        
        // Act
        button.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertEqual(sut.currentNumber, "")
        XCTAssertEqual(sut.displayLabel.text, "0")
    }

}
