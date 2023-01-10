//
//  RandTests.swift
//  DZ21Tests
//
//  Created by Dmitriy on 1/10/23.
//

import XCTest
@testable import DZ21

class RandViewControllerTests: XCTestCase {

    var sut: RandViewController!
    var mockPresenter: MockRandPresenter!
    
    override func setUp() {
        super.setUp()
        sut = RandViewController()
        mockPresenter = MockRandPresenter()
        sut.presenter = mockPresenter
        _ = sut.view // loads the view
    }

    override func tearDown() {
        sut = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    func test_buttonTapped_callsPresenter() {
        sut.button.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockPresenter.buttonTappedCalled())
    }
    
    func test_updateBackgroundColor_updatesViewBackgroundColor() {
        let color = UIColor.green
        sut.updateBackgroundColor(color)
        XCTAssertEqual(sut.view.backgroundColor, color)
    }
}

class MockRandPresenter: RandPresenterProtocol {
    var view: DZ21.RandViewProtocol?
    var interactor: DZ21.RandInteractorProtocol?
    var router: DZ21.RandRouterProtocol?
    var buttonCalled = true
    
    func buttonTapped() {
    }
    
    func didGenerateRandomColor(_ color: UIColor) {
    }
    
    func buttonTappedCalled() -> Bool {
        buttonCalled
    }
    
    func interactorDidFetchCats(with result: Result<[DZ21.Cat], Error>) {}
    var didCallButtonTap = false
    
    func handleSecondButtonTap() {
        didCallButtonTap = true
    }
    
    func handleButtonTap() {
        didCallButtonTap = true
    }
}

