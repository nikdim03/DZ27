//
//  CatPresenterTests.swift
//  DZ21Tests
//
//  Created by Dmitriy on 1/10/23.
//

import XCTest
@testable import DZ21

class CatPresenterTests: XCTestCase {
    var sut: CatPresenter!
    var mockView: CatListViewMock!
    var mockInteractor: CatListInteractorMock!
    var mockPresenter: MockPresenter!
    var mockRouter: CatListRouter!
    
    override func setUp() {
        mockRouter = CatRouter.start()
        mockPresenter = MockPresenter()

        mockView = CatListViewMock()
        mockInteractor = CatListInteractorMock()
        sut = CatPresenter()
        sut.view = mockView
        sut.interactor = mockInteractor
        sut.router = mockRouter
    }
    
    func test_interactorDidFetchCats_success_updatesView() {
        // Arrange
        let cats = [Cat(name: "Whiskers", imageName: "whiskers"), Cat(name: "Fluffy", imageName: "fluffy")]
        // Act
        sut.interactorDidFetchCats(with: .success(cats))
        // Assert
        for i in 0..<cats.count {
            XCTAssertEqual(mockView.updateCats![i].name, cats[i].name)
            XCTAssertEqual(mockView.updateCats![i].imageName, cats[i].imageName)
        }
    }
    
    func test_interactorDidFetchCats_failure_updatesView() {
        enum Error: Swift.Error {
            case networkError
        }
        sut.interactorDidFetchCats(with: .failure(Error.networkError))
        // Assert
        XCTAssertEqual(mockView.updateError, "Something went wrong")
    }
}

//Mock classes
class CatListViewMock: CatListView {
    var presenter: DZ21.CatsListPresenter?
    
    var updateCats: [Cat]?
    var updateError: String?
    
    func update(with cats: [Cat]) {
        updateCats = cats
    }
    
    func update(with error: String) {
        updateError = error
    }
    
    func handleButtonTap() {
    }
}

class CatListInteractorMock: CatListInteractor {
    var presenter: DZ21.CatsListPresenter?
    
    func getCats() {}
}
