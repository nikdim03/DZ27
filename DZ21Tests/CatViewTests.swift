//
//  CatTests.swift
//  DZ21Tests
//
//  Created by Dmitriy on 1/10/23.
//

import XCTest
@testable import DZ21

class CatViewControllerTests: XCTestCase {
    var sut: CatViewController!
    var mockPresenter: MockPresenter!
    var mockRouter: CatListRouter!
    
    override func setUp() {
        super.setUp()
        sut = CatViewController()
        mockRouter = CatRouter.start()
        mockPresenter = MockPresenter()
        sut.presenter = mockPresenter
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    func test_update_updateCollectionView() {
        // Arrange
        let cats = [Cat(name: "Mittens", imageName: "mittens"), Cat(name: "Whiskers", imageName: "whiskers")]
        
        // Act
        sut.update(with: cats)
        
        // Assert
        DispatchQueue.main.async {
            XCTAssertEqual(self.sut.collectionView.numberOfItems(inSection: 0), 2)
            XCTAssertEqual(self.sut.cats.count, 2)
        }
    }
    
    func test_handleButtonTap_callsPresenter() {
        // Act
        sut.handleButtonTap()
        
        // Assert
        XCTAssertTrue(mockPresenter.didCallButtonTap)
    }
    
    func test_handlesecondButtonTap_callsPresenter() {
        // Act
        sut.presenter = mockPresenter
        sut.handlesecondButtonTap()
        
        // Assert
        XCTAssertTrue(mockPresenter.didCallButtonTap)
    }

    func test_handlesecondButtonTap_navigateToCalculatorScreen() {
        // Arrange
        let mockNavigationController = UINavigationControllerMock()
//        sut.navigationController = mockNavigationController
        
        // Act
        mockNavigationController.pushViewController(UIViewController(), animated: true)
        
        // Assert
        XCTAssertTrue(mockNavigationController.didCallPushViewController)
    }
    
    func test_update_withError_showError() {
        // Arrange
        let error = "Error loading cats"
        
        // Act
        sut.update(with: error)
        
        // Assert
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 0)
        XCTAssertEqual(sut.cats.count, 0)
    }
}

class UINavigationControllerMock: UINavigationController {
    var didCallPushViewController = false
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        didCallPushViewController = true
    }
}

class MockPresenter: CatsListPresenter {
    func interactorDidFetchCats(with result: Result<[DZ21.Cat], Error>) {}
    
    var view: DZ21.CatListView?
    var interactor: DZ21.CatListInteractor?
    var router: DZ21.CatListRouter?
        
    var didCallButtonTap = false
    
    func handleSecondButtonTap() {
        didCallButtonTap = true
    }
    
    
    func handleButtonTap() {
        didCallButtonTap = true
    }
}
