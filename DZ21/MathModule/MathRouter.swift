//
//  MathRouter.swift
//  DZ21
//
//  Created by Dmitriy on 1/10/23.
//

import UIKit

//object
//entry point

protocol MathRouterProtocol {
    var view: MathViewProtocol? { get set }

    static func createModule() -> MathRouterProtocol
}

class MathRouter: MathRouterProtocol {

    var view: MathViewProtocol?

    static func createModule() -> MathRouterProtocol {
        let router = MathRouter()
        let view = MathViewController()
        let interactor = MathInteractor()
        let presenter = MathPresenter()

        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.view = view

        return router
    }
}
