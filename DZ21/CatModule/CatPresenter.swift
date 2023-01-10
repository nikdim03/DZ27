//
//  CatPresenter.swift
//  DZ21
//
//  Created by Dmitriy on 12/23/22.
//

import Foundation

//object
//protocol
//ref to view, interactor, presenter

protocol CatsListPresenter {
    var view: CatListView? { get set }
    var interactor: CatListInteractor? { get set }
    var router: CatListRouter? { get set }
    
    func interactorDidFetchCats(with result: Result<[Cat], Error>)
    func handleButtonTap()
    func handleSecondButtonTap()
}

class CatPresenter: CatsListPresenter {
    var view: CatListView?
    var interactor: CatListInteractor? {
        didSet {
            interactor?.getCats()
        }
    }
    var router: CatListRouter?
    
    func interactorDidFetchCats(with result: Result<[Cat], Error>) {
        switch result {
        case .success(let cats):
            view?.update(with: cats)
        case .failure(_):
            view?.update(with: "Something went wrong")
        }
    }
    func handleButtonTap() {
        router?.presentNewViewController()
    }
    func handleSecondButtonTap() {
        router?.presentMathController()
    }
}
