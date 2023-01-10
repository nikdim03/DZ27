//
//  RandPresenterTests.swift
//  DZ21Tests
//
//  Created by Dmitriy on 1/10/23.
//

import XCTest
@testable import DZ21

class RandPresenterTests: XCTestCase {
    
    var sut: RandPresenter!
    var mockView: MockView!
    var mockInteractor: MockInteractor!
    
    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockInteractor = MockInteractor()
        sut = RandPresenter()
        sut.view = mockView
        sut.interactor = mockInteractor
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockInteractor = nil
        sut = nil
    }
    
    func testButtonTapped_ShouldCallInteractorToGenerateRandomColor() {
        // Act
        sut.buttonTapped()
        
        // Assert
        XCTAssertTrue(mockInteractor.generateRandomColorCalled)
    }
    
    func testDidGenerateRandomColor_ShouldUpdateViewWithColor() {
        // Arrange
        let color = UIColor.red
        
        // Act
        sut.didGenerateRandomColor(color)
        
        // Assert
        XCTAssertEqual(mockView.updateBackgroundColorCalledWith, color)
    }
}

// MARK: - Mocks

class MockView: RandViewProtocol {
    var presenter: DZ21.RandPresenterProtocol?
    
    var updateBackgroundColorCalledWith: UIColor?
    func updateBackgroundColor(_ color: UIColor) {
        updateBackgroundColorCalledWith = color
    }
}

class MockInteractor: RandInteractorProtocol {
    var presenter: DZ21.RandPresenterProtocol?
    
    var generateRandomColorCalled = false
    func generateRandomColor() {
        generateRandomColorCalled = true
    }
}
