//
//  CatInteractor.swift
//  DZ21
//
//  Created by Dmitriy on 12/23/22.
//

import Foundation

//object
//protocol
//ref to presenter

protocol CatListInteractor {
    var presenter: CatsListPresenter? { get set }
    func getCats()
}

class CatInteractor: CatListInteractor {
    var presenter: CatsListPresenter?
    func getCats() {
        var cats = [Cat]()
        cats.append(Cat(name: "Beluga", imageName: "beluga"))
        cats.append(Cat(name: "Crier", imageName: "crier"))
        cats.append(Cat(name: "Flyer", imageName: "flyer"))
        cats.append(Cat(name: "Greg", imageName: "greg"))
        cats.append(Cat(name: "Hava", imageName: "hava"))
        cats.append(Cat(name: "Hecker", imageName: "hecker"))
        cats.append(Cat(name: "Heher", imageName: "heher"))
        cats.append(Cat(name: "Licker", imageName: "licker"))
        cats.append(Cat(name: "Nugget", imageName: "nugget"))
        cats.append(Cat(name: "Potato", imageName: "potato"))
        cats.append(Cat(name: "Scemer", imageName: "scemer"))
        cats.append(Cat(name: "Shitten", imageName: "shitten"))
        cats.append(Cat(name: "Smiler", imageName: "smiler"))
        cats.append(Cat(name: "Spatula", imageName: "spatula"))
        self.presenter?.interactorDidFetchCats(with: .success(cats))
    }
}
