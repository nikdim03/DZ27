//
//  CatRouter.swift
//  DZ21
//
//  Created by Dmitriy on 12/23/22.
//

import UIKit

//object
//entry point

typealias EntryPoint = CatListView & UIViewController

protocol CatListRouter {
    var entry: EntryPoint? { get } //view
    static func start() -> CatListRouter
    func presentNewViewController()
    func presentMathController()
}

class CatRouter: CatListRouter {
    var entry: EntryPoint?
    var view: CatListView?
    static func start() -> CatListRouter {
        let router = CatRouter()
        
        var view: CatListView = CatViewController()
        var interactor: CatListInteractor = CatInteractor()
        var presenter: CatsListPresenter = CatPresenter()

        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    func presentNewViewController() {
        guard let entry = entry else { return }
        let newRouter = RandRouter.createModule()
        let newViewController = newRouter.view
        entry.present(newViewController as! UIViewController, animated: true, completion: nil)
    }
    func presentMathController() {
        guard let entry = entry else { return }
        let newRouter = MathRouter.createModule()
        let newViewController = newRouter.view
        entry.present(newViewController as! UIViewController, animated: true, completion: nil)
    }
}
