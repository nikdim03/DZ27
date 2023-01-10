//
//  MathPresenterTests.swift
//  DZ21Tests
//
//  Created by Dmitriy on 1/10/23.
//

import XCTest
@testable import DZ21

class MathPresenterTests: XCTestCase {
    
    var sut: MathPresenterProtocol!
    var mockView: MathViewProtocol!
    var mockInteractor: MathInteractorProtocol!
    var mockRouter: MathRouterProtocol!
    
    override func setUp() {
        super.setUp()
        mockRouter = MathRouter.createModule()
        mockView = mockRouter.view!
        mockInteractor = mockView.presenter?.interactor
        sut = MathPresenter()
        sut.view = mockView
        sut.interactor = mockInteractor
        sut.router = mockRouter
    }
    
    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        sut = nil
        super.tearDown()
    }
    
    func test_PerformCalculation_WithAdditionOperator_UpdatesResult() {
        // Arrange
        mockView.leftOpeMath = "5"
        mockView.currentNumber = "3"
        mockView.currentOperator = "+"
        
        // Act
        sut.performCalculation()
        
        // Assert
        XCTAssertEqual(mockView.result, "8.0")
    }
    
    func test_PerformCalculation_WithSubtractionOperator_UpdatesResult() {
        // Arrange
        mockView.leftOpeMath = "10"
        mockView.currentNumber = "5"
        mockView.currentOperator = "-"
        
        // Act
        sut.performCalculation()
        
        // Assert
        XCTAssertEqual(mockView.result, "5.0")
    }
    
    func test_PerformCalculation_WithMultiplicationOperator_UpdatesResult() {
        // Arrange
        mockView.leftOpeMath = "10"
        mockView.currentNumber = "5"
        mockView.currentOperator = "*"
        
        // Act
        sut.performCalculation()
        
        // Assert
        XCTAssertEqual(mockView.result, "50.0")
    }
    
    func test_PerformCalculation_WithDivisionOperator_UpdatesResult() {
        // Arrange
        mockView.leftOpeMath = "10"
        mockView.currentNumber = "5"
        mockView.currentOperator = "/"
        
        // Act
        sut.performCalculation()
        
        // Assert
        XCTAssertEqual(mockView.result, "2.0")
    }
}
